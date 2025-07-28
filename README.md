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
APP_KEY=base64:SuaChaveLaravelAqui=
APP_URL=https://seu-dominio.com.br
DB_PASSWORD=SenhaBanco123
MYSQL_ROOT_PASSWORD=SenhaRoot456
```

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
