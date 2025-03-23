#!/bin/bash

echo "Updating package lists..."
sudo apt update

echo "Installing dependencies..."
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev

# Install Flutter if not installed
if ! command -v flutter &> /dev/null
then
    echo "Installing Flutter..."
    curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.3-stable.tar.xz
    tar -xf flutter_linux_3.16.3-stable.tar.xz
    sudo mv flutter /opt/
    echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc
    source ~/.bashrc
else
    echo "Flutter is already installed."
fi

# Install Chrome if not installed
if ! command -v google-chrome &> /dev/null
then
    echo "Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome is already installed."
fi

# Enable Flutter web support
flutter config --enable-web

# Check Flutter installation
flutter doctor

echo "Setup complete!"
