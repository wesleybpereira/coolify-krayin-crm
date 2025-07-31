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

**Versão Corrigida (RECOMENDADA) - Cria .env interno completo + HTTPS:**
```bash
sleep 30 && cd /var/www/html/laravel-crm && cat > .env << EOF
APP_NAME=\${APP_NAME:-"Krayin CRM"}
APP_ENV=\${APP_ENV:-production}
APP_KEY=\$APP_KEY
APP_DEBUG=\${APP_DEBUG:-false}
APP_URL=\$APP_URL
APP_TIMEZONE=\${APP_TIMEZONE:-UTC}
FORCE_HTTPS=true
ASSET_URL=\$APP_URL
DB_CONNECTION=\${DB_CONNECTION:-mysql}
DB_HOST=krayin-mysql
DB_PORT=\${DB_PORT:-3306}
DB_DATABASE=\${DB_DATABASE:-krayin}
DB_USERNAME=\${DB_USERNAME:-krayin_user}
DB_PASSWORD=\$DB_PASSWORD
CACHE_DRIVER=\${CACHE_DRIVER:-file}
SESSION_DRIVER=\${SESSION_DRIVER:-file}
QUEUE_CONNECTION=\${QUEUE_CONNECTION:-database}
LOG_CHANNEL=\${LOG_CHANNEL:-stack}
LOG_LEVEL=\${LOG_LEVEL:-error}
EOF
&& php artisan config:clear && php artisan krayin-crm:install && chown -R www-data:www-data storage bootstrap/cache && chmod -R 775 storage bootstrap/cache && php artisan storage:link && echo "✅ Krayin CRM configurado!"
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

### ❗ PROBLEMA PRINCIPAL: Por que APP_KEY não é reconhecido?

**EXPLICAÇÃO:**
- ✅ Coolify injeta `APP_KEY` como variável de ambiente no container  
- ✅ Docker Compose recebe e passa para o container
- ❌ **MAS** Laravel lê o arquivo `.env` interno, não as variáveis do sistema
- ❌ O arquivo `.env` dentro do container não é populado automaticamente

**VERIFICAÇÃO:**
```bash  
# 1. Dentro do container, verificar se variáveis existem no sistema:
env | grep APP_KEY
env | grep DB_

# 2. Verificar se existe .env interno (provavelmente NÃO existe ou está vazio):
cat .env | grep APP_KEY
```

### Erro: "No APP_KEY variable was found in the .env file"
```bash
# SOLUÇÃO DEFINITIVA - Criar .env interno com variáveis do sistema:

# 1. Navegar para diretório correto
cd /var/www/html/laravel-crm

# 2. Criar/popular .env com variáveis de ambiente do sistema
cat > .env << EOF
APP_NAME=${APP_NAME:-"Krayin CRM"}
APP_ENV=${APP_ENV:-production}
APP_KEY=$APP_KEY
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=$APP_URL
APP_TIMEZONE=${APP_TIMEZONE:-UTC}
FORCE_HTTPS=true
ASSET_URL=$APP_URL

DB_CONNECTION=${DB_CONNECTION:-mysql}
DB_HOST=krayin-mysql
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-krayin}
DB_USERNAME=${DB_USERNAME:-krayin_user}
DB_PASSWORD=$DB_PASSWORD

CACHE_DRIVER=${CACHE_DRIVER:-file}
SESSION_DRIVER=${SESSION_DRIVER:-file}
QUEUE_CONNECTION=${QUEUE_CONNECTION:-database}

LOG_CHANNEL=${LOG_CHANNEL:-stack}
LOG_LEVEL=${LOG_LEVEL:-error}
EOF

# 3. Verificar se foi criado corretamente
cat .env | grep APP_KEY
cat .env | grep DB_HOST

# 4. Limpar cache e executar instalação
php artisan config:clear
php artisan krayin-crm:install
```

### Erro: Mixed Content - CSS/JS carregando em HTTP em vez de HTTPS
```bash
# PROBLEMA: Assets (CSS/JS) carregando como http:// em vez de https://
# CAUSA: Laravel não está forçando HTTPS corretamente

# SOLUÇÃO 1 - Adicionar variáveis HTTPS no .env:
cd /var/www/html/laravel-crm
echo "FORCE_HTTPS=true" >> .env
echo "ASSET_URL=$APP_URL" >> .env
php artisan config:clear

# SOLUÇÃO 2 - Comando completo para recriar .env com HTTPS:
cat > .env << EOF
APP_NAME=${APP_NAME:-"Krayin CRM"}
APP_ENV=${APP_ENV:-production}
APP_KEY=$APP_KEY
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=$APP_URL
APP_TIMEZONE=${APP_TIMEZONE:-UTC}
FORCE_HTTPS=true
ASSET_URL=$APP_URL
DB_CONNECTION=${DB_CONNECTION:-mysql}
DB_HOST=krayin-mysql
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-krayin}
DB_USERNAME=${DB_USERNAME:-krayin_user}
DB_PASSWORD=$DB_PASSWORD
CACHE_DRIVER=${CACHE_DRIVER:-file}
SESSION_DRIVER=${SESSION_DRIVER:-file}
QUEUE_CONNECTION=${QUEUE_CONNECTION:-database}
LOG_CHANNEL=${LOG_CHANNEL:-stack}
LOG_LEVEL=${LOG_LEVEL:-error}
EOF

# 3. Limpar todos os caches
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# 4. Verificar se APP_URL está correto
php artisan tinker --execute="echo config('app.url');"
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
