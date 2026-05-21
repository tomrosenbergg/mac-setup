#!/bin/bash
set -euo pipefail

# Install Xcode Tools if not present
if ! xcode-select -p &>/dev/null; then
    echo "🛠️ Installing Xcode Command Line Tools..."
    xcode-select --install
else
    echo "✅ Xcode Command Line Tools already installed."
fi

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew already installed."
fi

# Install Ansible if not present
if ! command -v ansible &>/dev/null; then
    echo "🤖 Installing Ansible..."
    brew install ansible
else
    echo "✅ Ansible already installed."
fi

# Run the playbook
echo "🚀 Running Ansible Playbook..."
ansible-playbook mac-setup.yaml