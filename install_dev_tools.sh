#!/bin/bash

echo "🚀 Починаємо перевірку та встановлення інструментів DevOps..."

# 1. Перевірка та встановлення Docker
echo "--- 1. Docker ---"
if command -v docker &> /dev/null; then
    echo "✅ Docker вже встановлено: $(docker --version)"
else
    echo "⏳ Встановлюємо Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
fi

# 2. Перевірка та встановлення Docker Compose
echo "--- 2. Docker Compose ---"
if command -v docker-compose &> /dev/null; then
    echo "✅ Docker Compose вже встановлено: $(docker-compose --version)"
else
    echo "⏳ Встановлюємо Docker Compose..."
    sudo apt-get update
    sudo apt-get install -y docker-compose
fi

# 3. Перевірка та встановлення Python
echo "--- 3. Python ---"
if command -v python3 &> /dev/null; then
    echo "✅ Python вже встановлено: $(python3 --version)"
else
    echo "⏳ Встановлюємо Python..."
    sudo apt-get update
    sudo apt-get install -y python3
fi

# 4. Перевірка та встановлення Django
echo "--- 4. Django ---"
if python3 -m django --version &> /dev/null; then
    echo "✅ Django вже встановлено!"
else
    echo "⏳ Встановлюємо Django через pip..."
    # Оновлюємо список пакетів перед встановленням pip
    sudo apt-get update 
    sudo apt-get install -y python3-pip
    
    # Встановлюємо Django з дозволом для нових версій Ubuntu
    pip3 install django --break-system-packages
fi

echo "🎉 Готово! Усі інструменти перевірено та встановлено."
