#!/bin/bash

echo "=== Krayin CRM Post-Deploy Setup (Coolify) ==="

# O Coolify executa os comandos no contexto do container principal
# Não precisamos do docker exec aqui

# Aguardar banco estar pronto
echo "⏳ Aguardando banco de dados..."
sleep 30

# Testar conexão com banco
echo "🔗 Testando conexão com banco..."
php -r "
try {
    \$pdo = new PDO('mysql:host=krayin-db;dbname=krayin', 'krayin', getenv('DB_PASSWORD'));
    echo 'Conexão com banco OK!' . PHP_EOL;
} catch(PDOException \$e) {
    echo 'Erro na conexão: ' . \$e->getMessage() . PHP_EOL;
    exit(1);
}
"

# Executar o comando oficial de instalação do Krayin
echo "🚀 Executando: php artisan krayin-crm:install"
cd /var/www/html/laravel-crm
php artisan krayin-crm:install

# Configurar permissões de storage
echo "🔧 Configurando permissões..."
chown -R www-data:www-data /var/www/html/laravel-crm/storage
chmod -R 775 /var/www/html/laravel-crm/storage

# Limpar cache
echo "🧹 Limpando cache..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Criar link simbólico para storage
echo "🔗 Criando link simbólico..."
php artisan storage:link

echo ""
echo "✅ Setup do Krayin CRM concluído!"
echo "🔑 Credenciais padrão:"
echo "   Email: admin@example.com"
echo "   Senha: admin123"
