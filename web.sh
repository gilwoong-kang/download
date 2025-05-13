#!/bin/bash

echo "📦 Updating system packages..."
apt update -y && apt upgrade -y

echo "🌐 Installing required dependencies..."
apt install -y curl git build-essential

echo "🌐 Installing nvm (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "🟢 Installing Node.js LTS version..."
nvm install --lts

echo "🔧 Downloading practice files..."
git clone https://github.com/ktcloud-TnC/Basic /root/Basic

echo "📂 Creating path and moving files..."
mkdir -p /var/www
chmod +x /root/Basic/web/move.sh
bash /root/Basic/web/move.sh
cd /var/www/project01

echo "📦 Installing npm dependencies..."
npm install

echo "🏗️ Building the project..."
chmod +x /var/www/project01/node_modules/.bin/next
npm run build

echo "🚀 Starting the nextapp application with pm2..."
npm install pm2@latest -g
pm2 start npm --name "nextapp" -- run start

pm2 startup
pm2 save
pm2 status
