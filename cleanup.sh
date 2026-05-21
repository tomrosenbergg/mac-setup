#!/bin/bash
set -euo pipefail

# --- Simple & Safe macOS Cleanup ---

echo "🚀 Starting Safe Cleanup..."

# Safe cleaning function to avoid errors on non-existent directories or empty patterns
safe_clean() {
    local target="$1"
    # Resolve tilde manually if present, or rely on bash parameter/path
    if [ -d "$target" ]; then
        echo "🧹 Cleaning contents of: $target"
        # Use shell expansion safely, ensuring we don't rm -rf /* if variable is empty
        find "$target" -mindepth 1 -delete 2>/dev/null || true
    fi
}

# 1. Homebrew Maintenance
if command -v brew &> /dev/null; then
    echo "📦 Cleaning Homebrew caches..."
    brew cleanup -s
    brew autoremove
fi

# 2. System & User Logs (Safe to delete, they regenerate)
echo "📜 Clearing System Logs..."
# sudo logs might need password; if ran non-interactively or fails, let's allow it to continue
sudo rm -rf /private/var/log/* 2>/dev/null || true
sudo rm -rf /Library/Logs/* 2>/dev/null || true
safe_clean "$HOME/Library/Logs"

# 3. User Caches (The 'Fridge' - safe to clear)
# We delete contents but keep the folder to avoid permission issues
safe_clean "$HOME/Library/Caches"

# 4. Surgical Strikes on App Support Bloat (Targeted Caches)
echo "🎯 Targeting App Support bloat (Claude, Chrome, Spotify)..."
safe_clean "$HOME/Library/Application Support/Claude/Cache"
safe_clean "$HOME/Library/Application Support/Claude/Code Cache"
safe_clean "$HOME/Library/Application Support/Google/Chrome/Default/Service Worker/CacheStorage"
safe_clean "$HOME/Library/Application Support/Google/Chrome/Default/Code Cache"
safe_clean "$HOME/Library/Application Support/Spotify/PersistentCache"

# 5. Xcode/Developer Cleanup (Only if folder exists - correctly handles tilde/HOME)
safe_clean "$HOME/Library/Developer/Xcode/DerivedData"

# 6. Empty the Trash
echo "🗑️ Emptying Trash..."
safe_clean "$HOME/.Trash"

echo "✅ Done! Check your 'topsize' again to see the difference."