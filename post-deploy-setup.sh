#!/bin/bash

echo "=== Krayin CRM Post-Deploy Setup ==="
echo "Este script deve ser executado APÓS o deploy do Coolify estar funcionando"
echo ""

CONTAINER_NAME="krayin-app"

# Verificar se o container está rodando
if ! docker ps | grep -q $CONTAINER_NAME; then
    echo "❌ ERRO: Container $CONTAINER_NAME não está rodando!"
    echo "Execute primeiro: docker-compose up -d"
    exit 1
fi

echo "✅ Container encontrado. Executando comandos de setup..."
echo ""

# Aguardar banco estar pronto
echo "⏳ Aguardando banco de dados..."
sleep 10

# Executar o comando oficial de instalação do Krayin
echo "🚀 Executando: php artisan krayin-crm:install"
docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan krayin-crm:install

# Configurar permissões de storage
echo "🔧 Configurando permissões..."
docker exec $CONTAINER_NAME chown -R www-data:www-data /var/www/html/laravel-crm/storage
docker exec $CONTAINER_NAME chmod -R 775 /var/www/html/laravel-crm/storage

# Limpar cache
echo "🧹 Limpando cache..."
docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan cache:clear
docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan config:clear
docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan route:clear
docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan view:clear

echo ""
echo "✅ Setup concluído!"
echo ""
echo "🌐 Acesse o Krayin CRM em: ${APP_URL:-http://localhost:8082}"
echo "🔑 Login do Admin:"
echo "   Email: admin@example.com"
echo "   Senha: admin123"
echo ""
echo "📖 Para mais informações, consulte: https://devdocs.krayincrm.com/"
