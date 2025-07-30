#!/bin/bash

echo "=== Krayin CRM Initialization Script ==="
echo "Waiting for database to be ready..."

# Aguardar o banco estar pronto
sleep 30

# Função para testar conexão com banco
test_db_connection() {
    echo "Testing database connection..."
    php -r "
    try {
        \$pdo = new PDO('mysql:host=krayin-db;dbname=krayin', 'krayin', getenv('DB_PASSWORD'));
        echo 'Database connection successful!' . PHP_EOL;
        return true;
    } catch(PDOException \$e) {
        echo 'Connection failed: ' . \$e->getMessage() . PHP_EOL;
        return false;
    }
    "
}

# Parar MySQL interno se estiver rodando
echo "Stopping internal MySQL if running..."
supervisorctl stop mysql 2>/dev/null || true

# Verificar conexão com banco
if test_db_connection; then
    echo "Database connection successful!"
else
    echo "Database connection failed! Exiting..."
    exit 1
fi

# Executar migrações
echo "Running database migrations..."
php /var/www/html/laravel-crm/artisan migrate --force

# Verificar se precisa fazer seed
USER_COUNT=$(php /var/www/html/laravel-crm/artisan tinker --execute="echo DB::table('users')->count();" 2>/dev/null | tail -1)

if [ "$USER_COUNT" = "0" ] || [ -z "$USER_COUNT" ]; then
    echo "First installation - running seeders..."
    php /var/www/html/laravel-crm/artisan db:seed --force
    
    echo "Setting up Passport..."
    php /var/www/html/laravel-crm/artisan passport:install --force
else
    echo "System already initialized ($USER_COUNT users found)"
fi

# Criar link simbólico para storage
echo "Creating storage symbolic link..."
php /var/www/html/laravel-crm/artisan storage:link 2>/dev/null || true

# Configurar permissões
echo "Setting proper permissions..."
chown -R www-data:www-data /var/www/html/laravel-crm/storage
chmod -R 775 /var/www/html/laravel-crm/storage

echo "=== Krayin CRM Initialization Complete ==="

# Iniciar Apache
echo "Starting Apache..."
exec apache2ctl -D FOREGROUND
