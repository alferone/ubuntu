#!/bin/bash

# Скрипт установки Docker на Ubuntu 24.04/22.04
# Проверка версии Ubuntu
echo "Проверка версии Ubuntu..."
if ! grep -qE "(22\.04|24\.04)" /etc/os-release; then
    echo "⚠️  Предупреждение: Скрипт тестировался на Ubuntu 22.04/24.04"
fi

echo "🔄 Обновление системы..."
sudo apt update

echo "📦 Установка необходимых пакетов..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔐 Добавление официального GPG ключа Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "📋 Добавление репозитория Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Обновление списка пакетов..."
sudo apt update

echo "📥 Установка Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🔧 Добавление текущего пользователя в группу docker..."
sudo usermod -aG docker $USER

echo "🚀 Запуск и включение службы Docker..."
sudo systemctl start docker
sudo systemctl enable docker

echo "✅ Установка завершена!"
echo "🔄 Пожалуйста, выйдите из системы и войдите снова, чтобы изменения вступили в силу"
echo "🧪 Проверьте установку командой: docker --version"
