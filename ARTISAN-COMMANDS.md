# Comandos Artisan para Krayin CRM - Guia Completo

## 🚀 Comando Principal (OBRIGATÓRIO)

**Para instalação inicial completa:**
```bash
php artisan krayin-crm:install
```

Este comando fará:
- Verificar configurações do `.env`
- Executar migrações do banco de dados
- Popular banco com dados iniciais (seeders)
- Criar usuário administrador padrão
- Configurar permissões básicas

## 📋 Comandos para Post Deployment Commands do Coolify

**Versão Corrigida (RECOMENDADA) - Resolve problemas de .env:**
```bash
sleep 30 && cd /var/www/html/laravel-crm && echo "DB_HOST=krayin-mysql" >> .env && echo "DB_PORT=3306" >> .env && echo "DB_DATABASE=${DB_DATABASE:-krayin}" >> .env && echo "DB_USERNAME=${DB_USERNAME:-krayin_user}" >> .env && echo "DB_PASSWORD=${DB_PASSWORD}" >> .env && echo "APP_KEY=${APP_KEY}" >> .env && php artisan config:clear && php artisan krayin-crm:install && chown -R www-data:www-data storage bootstrap/cache && chmod -R 775 storage bootstrap/cache && php artisan storage:link && echo "✅ Krayin CRM configurado!"
```

**Versão Completa Original:**
```bash
sleep 30 && cd /var/www/html && php artisan krayin-crm:install && chown -R www-data:www-data storage bootstrap/cache && chmod -R 775 storage bootstrap/cache && php artisan storage:link && echo "✅ Krayin CRM configurado!"
```

**Versão Mínima:**
```bash
sleep 30 && cd /var/www/html && php artisan krayin-crm:install && php artisan storage:link
```

## 🔧 Comandos Manuais Adicionais (se necessário)

### ⚡ SOLUÇÃO PARA SEU ERRO ATUAL:
```bash
# Execute estes comandos na ordem para corrigir o problema:

# 1. Navegar para diretório correto
cd /var/www/html/laravel-crm

# 2. Configurar .env com variáveis corretas
echo "DB_HOST=krayin-mysql" >> .env
echo "DB_PORT=3306" >> .env
echo "DB_DATABASE=krayin" >> .env
echo "DB_USERNAME=krayin_user" >> .env
echo "DB_PASSWORD=sua_senha_aqui" >> .env
echo "APP_KEY=$APP_KEY" >> .env

# 3. Limpar cache de configuração
php artisan config:clear

# 4. Testar conexão com banco
php artisan tinker --execute="DB::connection()->getPdo(); echo 'Conexão OK!';"

# 5. Executar instalação
php artisan krayin-crm:install

# 6. Configurar permissões
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

# 7. Criar link simbólico
php artisan storage:link
```

### Após primeira instalação:
```bash
# 1. Limpar caches
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# 2. Criar link simbólico para storage
php artisan storage:link

# 3. Configurar permissões (dentro do container)
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache
```

### Para reinstalação/reset:
```bash
# CUIDADO: Isso apagará todos os dados!
php artisan migrate:fresh --seed
php artisan krayin-crm:install
```

### Para apenas migrações:
```bash
php artisan migrate --force
```

### Para apenas seeders:
```bash
php artisan db:seed --force
```

## 📊 Verificar Status

### Verificar migrações:
```bash
php artisan migrate:status
```

### Verificar banco de dados:
```bash
php artisan tinker
# No tinker:
DB::connection()->getPdo();
DB::table('users')->count();
```

### Verificar configuração:
```bash
php artisan config:show
```

## 🔑 Credenciais Padrão

Após executar `php artisan krayin-crm:install`:
- **Email**: admin@example.com
- **Senha**: admin123

## 🚨 Troubleshooting

### Erro: "No APP_KEY variable was found in the .env file"
```bash
# 1. Verificar se as variáveis estão no container
env | grep APP_KEY
env | grep DB_

# 2. Se não estiverem, criar/atualizar .env manualmente
echo "APP_KEY=$APP_KEY" >> .env
echo "DB_HOST=krayin-mysql" >> .env
echo "DB_DATABASE=$DB_DATABASE" >> .env
echo "DB_USERNAME=$DB_USERNAME" >> .env
echo "DB_PASSWORD=$DB_PASSWORD" >> .env

# 3. Depois executar
php artisan config:clear
php artisan krayin-crm:install
```

### Erro: "Access denied for user" ou "localhost"
```bash
# O problema é que o installer está usando localhost em vez de krayin-mysql
# Execute estes comandos ANTES do krayin-crm:install:

# 1. Verificar se .env existe e está correto
cat .env | grep DB_HOST

# 2. Se não existir ou estiver errado, criar/corrigir:
echo "DB_HOST=krayin-mysql" >> .env
echo "DB_PORT=3306" >> .env
echo "DB_DATABASE=krayin" >> .env
echo "DB_USERNAME=krayin_user" >> .env
echo "DB_PASSWORD=sua_senha_aqui" >> .env

# 3. Testar conexão
php artisan tinker --execute="DB::connection()->getPdo(); echo 'Conexão OK';"
```

### Se der erro de permissão:
```bash
sudo chown -R www-data:www-data /var/www/html/storage
sudo chown -R www-data:www-data /var/www/html/bootstrap/cache
sudo chmod -R 775 /var/www/html/storage
sudo chmod -R 775 /var/www/html/bootstrap/cache
```

### Se der erro de APP_KEY:
```bash
php artisan key:generate
```

### Se der erro de conexão com banco:
```bash
# Testar conexão
php artisan tinker
# No tinker: DB::connection()->getPdo();
```

## 📝 Ordem de Execução Recomendada

1. **Deploy no Coolify** com as variáveis de ambiente configuradas
2. **Aguardar containers iniciarem** (30-60 segundos)
3. **Executar comando post-deploy** ou manual:
   ```bash
   php artisan krayin-crm:install
   ```
4. **Verificar funcionamento** acessando a URL
5. **Login com credenciais padrão**

## 🔄 Para Updates/Redeploy

Se você já tem Krayin funcionando e faz um redeploy:
```bash
# Apenas limpar caches
php artisan cache:clear && php artisan config:clear
```

**NÃO** execute `krayin-crm:install` novamente, pois isso pode resetar dados!
