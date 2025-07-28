# Krayin CRM - Configuração Simplificada para Coolify

## 🎯 **VERSÃO ULTRA-SIMPLIFICADA: 1 Container Apenas!**

Esta é a versão mais simples possível - apenas 1 container com MySQL interno integrado.

## 📋 Arquivos necessários

- `docker-compose.yml` - Arquivo principal (apenas 1 container!)
- `.env` - Variáveis de ambiente (já existente)

> **📁 Arquivos opcionais removidos:**
> - ~~`mysql-init.sql`~~ - Não precisamos mais (MySQL interno)
> - ~~`docker-compose-complex.yml`~~ - Versão anterior (backup)

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
- Faça upload **APENAS** do `docker-compose.yml` para o seu projeto no Coolify

### 3. Variáveis de ambiente obrigatórias
Configure **APENAS** estas 4 variáveis na interface do Coolify:

```bash
# === OBRIGATÓRIAS ===
APP_KEY=${APP_KEY}                              # Gere com: php artisan key:generate --show
APP_URL=https://seu-dominio.com.br             # URL completa da sua aplicação
DB_PASSWORD=${DB_PASSWORD}                      # Senha forte para o banco interno
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}     # Senha forte para o root do MySQL interno
```

> **🎉 Só isso!** As demais configurações têm valores padrão otimizados.

> **⚠️ Importante:** Substitua `${VARIAVEL}` pelos valores reais:
> - `APP_KEY`: Gere uma chave Laravel válida
> - `APP_URL`: Seu domínio/subdomínio real
> - `DB_PASSWORD`: Senha forte (min. 12 caracteres)
> - `MYSQL_ROOT_PASSWORD`: Senha forte diferente da anterior

### 4. Arquitetura simplificada
A nova configuração usa apenas:
1. **krayin** - Container único com Apache + MySQL interno integrado

### 5. Volumes persistentes
- `krayin_storage` - Arquivos da aplicação
- `krayin_uploads` - Uploads do usuário  
- `krayin_db_data` - Dados do banco MySQL interno

## 🚀 Deploy no Coolify

1. Crie um novo projeto no Coolify
2. Selecione "Docker Compose"
3. Faça upload **APENAS** do `docker-compose.yml`
4. Configure as **4 variáveis obrigatórias** listadas acima
5. **⚠️ IMPORTANTE**: Configure domínio para o único serviço `krayin`
6. Clique em "Deploy"

### 🌐 Configuração de domínios
- ✅ **`krayin`** → Configure seu domínio (exemplo: `crm.seudominio.com`)

> **🎉 Muito mais simples!** Apenas 1 serviço vs 3 da versão anterior.

## 🔍 Verificação pós-deploy

Após o deploy, verifique:
- ✅ Container `krayin` está rodando e saudável
- ✅ Aplicação acessível via `APP_URL`

> **🚀 Muito mais simples!** Apenas 1 container para monitorar.

## 📝 Características desta configuração

### ✅ Melhorias da versão simplificada:
- **1 Container apenas**: Apache + MySQL integrados (como deveria ser)
- **4 variáveis obrigatórias**: Configuração mínima necessária
- **Startup ultra-rápido**: Sem dependências complexas entre containers
- **Menos recursos**: Menor uso de RAM/CPU
- **Troubleshooting fácil**: Tudo em um lugar só
- **Arquitetura nativa**: Usa a imagem como foi projetada

### 🔧 Troubleshooting:
- **Container não sobe**: Verifique se as 4 variáveis obrigatórias estão definidas
- Se houver erro de conexão, verifique `DB_PASSWORD` e `MYSQL_ROOT_PASSWORD`
- Se o debug aparecer, confirme `APP_DEBUG=false` e `DEBUGBAR_ENABLED=false`
- Para reset completo, remova os volumes no Coolify e redeploy

## 📞 Suporte
Em caso de problemas, verifique os logs do container `krayin` no painel do Coolify.

> **💡 Versão anterior:** Se precisar da versão mais complexa (3 containers), ela está salva como `docker-compose-complex.yml`
