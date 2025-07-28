# Krayin CRM - Configuração para Coolify

## 📋 Arquivos necessários

- `docker-compose.yml` - Arquivo principal do Docker Compose
- `mysql-init.sql` - Script de inicialização do banco de dados
- `.env` - Variáveis de ambiente (já existente)

## 🔧 Configuração no Coolify

### 1. Geração de valores seguros
Antes de configurar, gere valores seguros para as variáveis obrigatórias:

```bash
# Gerar APP_KEY (Laravel)
php artisan key:generate --show

# Ou gerar online: https://generate-random.org/laravel-key-generator

# Gerar senhas fortes (recomendado: 16+ caracteres)
openssl rand -base64 24

# Ou usar geradores online seguros
```

### 2. Upload dos arquivos
- Faça upload do `docker-compose.yml` e `mysql-init.sql` para o seu projeto no Coolify

### 3. Variáveis de ambiente obrigatórias
Configure estas variáveis na interface do Coolify:

```bash
# === OBRIGATÓRIAS ===
APP_KEY=${APP_KEY}                              # Gere com: php artisan key:generate --show
APP_URL=https://seu-dominio.com.br             # URL completa da sua aplicação
DB_PASSWORD=${DB_PASSWORD}                      # Senha forte para o usuário krayin
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}     # Senha forte para o root do MySQL

# === CONFIGURAÇÃO DA APLICAÇÃO ===
APP_ENV=production
APP_DEBUG=false
DEBUGBAR_ENABLED=false
APP_TIMEZONE=America/Sao_Paulo
APP_CIPHER=AES-256-CBC

# === BANCO DE DADOS ===
DB_CONNECTION=mysql
DB_HOST=krayin-db
DB_PORT=3306
DB_DATABASE=krayin
DB_USERNAME=krayin

# === CACHE E SESSÃO ===
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=database

# === LOGS ===
LOG_CHANNEL=stack
LOG_LEVEL=error

# === REDE (OPCIONAL) ===
APP_PORT=8082
```

> **⚠️ Importante:** Substitua `${VARIAVEL}` pelos valores reais:
> - `APP_KEY`: Gere uma chave Laravel válida
> - `APP_URL`: Seu domínio/subdomínio real
> - `DB_PASSWORD`: Senha forte (min. 12 caracteres)
> - `MYSQL_ROOT_PASSWORD`: Senha forte diferente da anterior

### 4. Ordem de inicialização
O Docker Compose está configurado para:
1. **krayin-db** - Inicia primeiro e configura o banco
2. **krayin-init** - Executa migrações e seeds (só na primeira vez)
3. **krayin** - Inicia a aplicação principal

### 5. Volumes persistentes
- `krayin_storage` - Arquivos da aplicação
- `krayin_uploads` - Uploads do usuário
- `krayin_db_data` - Dados do banco MySQL

## 🚀 Deploy no Coolify

1. Crie um novo projeto no Coolify
2. Selecione "Docker Compose"
3. Faça upload do `docker-compose.yml`
4. Faça upload do `mysql-init.sql`
5. Configure as variáveis de ambiente listadas acima
6. **⚠️ IMPORTANTE**: Configure domínio APENAS para o serviço `krayin` (aplicação principal)
7. Clique em "Deploy"

### 🌐 Configuração de domínios
- ✅ **`krayin`** → Configure seu domínio (exemplo: `crm.seudominio.com`)
- ❌ **`krayin-init`** → NÃO configure domínio (é só inicialização)
- ❌ **`krayin-db`** → NÃO configure domínio (banco interno)

## 🔍 Verificação pós-deploy

Após o deploy, verifique:
- ✅ Container `krayin-db` está saudável
- ✅ Container `krayin-init` completou com sucesso
- ✅ Container `krayin` está rodando
- ✅ Aplicação acessível via `APP_URL`

## 📝 Características desta configuração

### ✅ Melhorias implementadas:
- **Persistência de dados**: Volumes nomeados garantem que dados não se percam
- **Inicialização robusta**: Container de init executa migrações apenas na primeira vez
- **Healthchecks**: Monitora saúde dos containers
- **Variáveis flexíveis**: Usa variáveis de ambiente do Coolify
- **Network isolada**: Containers em rede dedicada
- **Permissões corretas**: Script ajusta permissões automaticamente

### 🔧 Troubleshooting:
- Se houver erro de conexão, verifique as variáveis `DB_*`
- Se o debug aparecer, confirme `APP_DEBUG=false` e `DEBUGBAR_ENABLED=false`
- Para reset completo, remova os volumes no Coolify e redeploy

## 📞 Suporte
Em caso de problemas, verifique os logs de cada container no painel do Coolify.
