#!/bin/bash

echo "=== Diagnóstico de Conexão ao Banco de Dados Krayin ==="
echo "Data/Hora: $(date)"
echo ""

echo "=== Verificando conectividade de rede ==="
echo "Testando ping para o host krayin-db..."
docker exec krayin-app ping -c 3 krayin-db || echo "ERRO: Não foi possível fazer ping no container krayin-db"
echo ""

echo "=== Verificando serviço MySQL ==="
echo "Status do container krayin-db:"
docker ps -a | grep krayin-db
echo ""

echo "=== Logs do container MySQL ==="
docker logs --tail 20 krayin-db
echo ""

echo "=== Tentando conexão direta ao MySQL ==="
echo "A partir do container krayin-app:"
docker exec krayin-app bash -c 'mysql -h krayin-db -u krayin -p"$DB_PASSWORD" -e "SHOW DATABASES;"' || echo "ERRO: Falha na conexão direta MySQL"
echo ""

echo "=== Verificando variáveis de ambiente no container Krayin ==="
docker exec krayin-app bash -c 'echo "DB_HOST=$DB_HOST"; echo "DB_USERNAME=$DB_USERNAME"; echo "DB_PASSWORD=$DB_PASSWORD"; echo "DB_DATABASE=$DB_DATABASE"'
echo ""

echo "=== Verificando arquivo .env no Laravel ==="
docker exec krayin-app bash -c 'grep -E "^DB_" /var/www/html/laravel-crm/.env'
echo ""

echo "=== Testando conexão PDO via PHP ==="
docker exec krayin-app bash -c 'php -r "try { \$pdo = new PDO(\"mysql:host=krayin-db;dbname=krayin\", \"krayin\", \"$DB_PASSWORD\"); echo \"Conexão PDO bem sucedida!\n\"; } catch (PDOException \$e) { echo \"Falha na conexão PDO: \" . \$e->getMessage() . \"\n\"; }"'
echo ""

echo "=== Estado do diretório de cache do Laravel ==="
docker exec krayin-app bash -c 'ls -la /var/www/html/laravel-crm/storage/framework/ || echo "Diretório não encontrado"'
echo ""

echo "=== Verificando MySQL interno ==="
docker exec krayin-app bash -c 'ps aux | grep mysql || echo "MySQL interno não encontrado"'
echo ""

echo "=== Verificando portas abertas ==="
docker exec krayin-app bash -c 'netstat -tulpn || echo "netstat não disponível - instalando"; apt-get update -qq && apt-get install -yqq net-tools && netstat -tulpn'
echo ""

echo "=== Diagnóstico concluído ==="
