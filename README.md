# Krayin CRM - Deploy no Coolify

## 📋 Arquivos necessários

- `docker-compose.yml` - Configuração do container

## 🔧 Configuração

### 1. Geração da chave Laravel
```bash
# Gere online: https://generate-random.org/laravel-key-generator
```

### 2. Variáveis obrigatórias no Coolify
```bash

# Variáveis para Coolify - Krayin CRM
# ⚠️ ALTERE os valores abaixo

# === OBRIGATÓRIAS - ALTERAR ESTES VALORES ===
APP_KEY=base64:SUA_CHAVE_LARAVEL_AQUI_32_CARACTERES=
APP_URL=https://seu-dominio.com.br
DB_PASSWORD=SuaSenhaSegura123
MYSQL_ROOT_PASSWORD=OutraSenhaRoot456

# === APLICAÇÃO (PADRÃO - PODE ALTERAR SE NECESSÁRIO) ===
APP_ENV=production
APP_DEBUG=false
DEBUGBAR_ENABLED=false
APP_TIMEZONE=America/Sao_Paulo
APP_CIPHER=AES-256-CBC

# === BANCO DE DADOS EXTERNO (PADRÃO - PODE ALTERAR SE NECESSÁRIO) ===
DB_CONNECTION=mysql
DB_HOST=krayin-db
DB_PORT=3306
DB_DATABASE=krayin
DB_USERNAME=krayin
MYSQL_DATABASE=krayin
MYSQL_USER=krayin
MYSQL_PASSWORD=SuaSenhaSegura123

# === CACHE E SESSÃO (PADRÃO - PODE ALTERAR SE NECESSÁRIO) ===
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=database

# === LOGS (PADRÃO - PODE ALTERAR SE NECESSÁRIO) ===
LOG_CHANNEL=stack
LOG_LEVEL=error

# === PORTA (OPCIONAL - PODE ALTERAR SE NECESSÁRIO) ===
APP_PORT=8082
```
### === INSTRUÇÕES ===
1. OBRIGATÓRIO: Gere APP_KEY em https://generate-random.org/laravel-key-generator
2. OBRIGATÓRIO: Substitua "seu-dominio.com.br" pelo seu domínio real
3. OBRIGATÓRIO: Mude "SuaSenhaSegura123" para uma senha forte (min. 12 chars)
4. OBRIGATÓRIO: Mude "OutraSenhaRoot456" para outra senha forte diferente
5. ⚠️ CRÍTICO: DB_PASSWORD e MYSQL_PASSWORD devem ter EXATAMENTE a mesma senha!
   - DB_PASSWORD: senha que o Laravel usa para conectar
   - MYSQL_PASSWORD: senha que o MySQL cria para o usuário 'krayin'
   - Se forem diferentes, dará erro de autenticação!
#### === CREDENCIAIS PADRÃO KRAYIN ===
   - 📧 Email: admin@example.com
   - 🔑 Senha: admin123
   - (Criadas automaticamente pelos seeders na primeira inicialização)

## 🚀 Deploy

1. Crie projeto no Coolify → Docker Compose
2. Upload do `docker-compose.yml`
3. Configure as 4 variáveis acima
4. Configure domínio no serviço `krayin`
5. Deploy

## 🔍 Verificação

- ✅ Container `krayin` rodando
- ✅ Site acessível no domínio configurado

## 💾 Dados

Volumes persistentes:
- `krayin_storage` - Aplicação
- `krayin_uploads` - Uploads  
- `krayin_db_data` - Banco de dados

> **Redeploy é seguro** - dados são preservados pelos volumes.

# === TROUBLESHOOTING ===
# ❌ Erro "Access denied" após mudar senhas?
# 1. PARE a aplicação no Coolify
# 2. VÁ em "Storages/Volumes" 
# 3. DELETE o volume "krayin_db_data"
# 4. REDEPLOY - MySQL será recriado com novas senhas
