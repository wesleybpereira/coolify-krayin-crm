#!/bin/bash

echo "=== Krayin CRM External Setup Script ==="

CONTAINER_NAME="krayin-app"

# Verificar se o container está rodando
if ! docker ps | grep -q $CONTAINER_NAME; then
    echo "Error: Container $CONTAINER_NAME is not running!"
    exit 1
fi

echo "Container found. Running setup commands..."

# Executar comandos no container
docker exec $CONTAINER_NAME bash -c "
    echo 'Testing database connection...'
    php /var/www/html/laravel-crm/artisan tinker --execute='
        try {
            DB::connection()->getPdo();
            echo \"Database connection successful!\";
        } catch(Exception \$e) {
            echo \"Connection failed: \" . \$e->getMessage();
            exit(1);
        }
    '
"

docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan migrate --force

docker exec $CONTAINER_NAME bash -c "
    USER_COUNT=\$(php /var/www/html/laravel-crm/artisan tinker --execute='echo DB::table(\"users\")->count();' 2>/dev/null | tail -1)
    if [ \"\$USER_COUNT\" = \"0\" ] || [ -z \"\$USER_COUNT\" ]; then
        echo 'First installation - running seeders...'
        php /var/www/html/laravel-crm/artisan db:seed --force
        php /var/www/html/laravel-crm/artisan passport:install --force
    else
        echo \"System already initialized (\$USER_COUNT users found)\"
    fi
"

docker exec $CONTAINER_NAME php /var/www/html/laravel-crm/artisan storage:link

docker exec $CONTAINER_NAME bash -c "
    chown -R www-data:www-data /var/www/html/laravel-crm/storage
    chmod -R 775 /var/www/html/laravel-crm/storage
"

echo "=== Setup Complete ==="
