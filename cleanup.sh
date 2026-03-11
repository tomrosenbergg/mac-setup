#!/bin/bash

# --- Simple & Safe macOS Cleanup ---

echo "🚀 Starting Safe Cleanup..."

# 1. Homebrew Maintenance
if command -v brew &> /dev/null; then
    echo "📦 Cleaning Homebrew caches..."
    brew cleanup -s
    brew autoremove
fi

# 2. System & User Logs (Safe to delete, they regenerate)
echo "📜 Clearing System Logs..."
sudo rm -rf /private/var/log/*
sudo rm -rf /Library/Logs/*
rm -rf ~/Library/Logs/*

# 3. User Caches (The 'Fridge' - safe to clear)
echo "🧹 Clearing User Caches..."
# We delete contents but keep the folder to avoid permission issues
rm -rf ~/Library/Caches/*

# 4. Surgical Strikes on App Support Bloat (Targeted Caches)
echo "🎯 Targeting App Support bloat (Claude & Chrome)..."
rm -rf ~/Library/Application\ Support/Claude/Cache/*
rm -rf ~/Library/Application\ Support/Claude/Code\ Cache/*
rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/*
rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Code\ Cache/*
rm -rf ~/Library/Application\ Support/Spotify/PersistentCache/*

# 5. Xcode/Developer Cleanup (Only if folder exists)
if [ -d "~/Library/Developer/Xcode/DerivedData" ]; then
    echo "🛠️ Clearing Xcode DerivedData..."
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
fi

# 6. Empty the Trash
echo "🗑️ Emptying Trash..."
rm -rf ~/.Trash/*

echo "✅ Done! Check your 'topsize' again to see the difference."