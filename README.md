# Krayin CRM - Configuração para Coolify

## 📋 Arquivos necessários

- `docker-compose.yml` - Arquivo principal do Docker Compose
- `mysql-init.sql` - Script de inicialização do banco de dados
- `.env` - Variáveis de ambiente (já existente)

## 🔧 Configuração no Coolify

### 1. Upload dos arquivos
- Faça upload do `docker-compose.yml` e `mysql-init.sql` para o seu projeto no Coolify

### 2. Variáveis de ambiente obrigatórias
Configure estas variáveis na interface do Coolify:

```bash
# Aplicação
APP_KEY=base64:dTTkWP2vgh7rs8CtWcw47tdCd7gpMEggdZ5WRwLlHAY=
APP_URL=https://crm.dachdigital.com.br
APP_ENV=production
APP_DEBUG=false
DEBUGBAR_ENABLED=false
APP_TIMEZONE=America/Sao_Paulo
APP_CIPHER=AES-256-CBC

# Banco de dados
DB_CONNECTION=mysql
DB_HOST=krayin-db
DB_PORT=3306
DB_DATABASE=krayin
DB_USERNAME=krayin
DB_PASSWORD=pefvon-wuMcoz-8qupqe

# MySQL Root
MYSQL_ROOT_PASSWORD=RV2yYmv6mxKzIAv

# Cache e Sessão
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=database

# Logs
LOG_CHANNEL=stack
LOG_LEVEL=error

# Porta (opcional)
APP_PORT=8082
```

### 3. Ordem de inicialização
O Docker Compose está configurado para:
1. **krayin-db** - Inicia primeiro e configura o banco
2. **krayin-init** - Executa migrações e seeds (só na primeira vez)
3. **krayin** - Inicia a aplicação principal

### 4. Volumes persistentes
- `krayin_storage` - Arquivos da aplicação
- `krayin_uploads` - Uploads do usuário
- `krayin_db_data` - Dados do banco MySQL

## 🚀 Deploy no Coolify

1. Crie um novo projeto no Coolify
2. Selecione "Docker Compose"
3. Faça upload do `docker-compose.yml`
4. Faça upload do `mysql-init.sql`
5. Configure as variáveis de ambiente listadas acima
6. Clique em "Deploy"

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
