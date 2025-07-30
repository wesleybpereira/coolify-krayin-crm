# Krayin CRM - Instalação no Coolify (Abordagem Oficial)

Baseado na [documentação oficial do Krayin](https://devdocs.krayincrm.com/2.0/introduction/docker.html), este projeto oferece duas abordagens para instalação:

## 🚀 Abordagem Recomendada (Coolify Post-Deploy)

### Opção 1: Usando Post Deployment Commands do Coolify
- **Arquivo**: `docker-compose.yml` (versão limpa)
- **Setup**: Automático via Coolify
- **Como usar**: Configure no campo "Post Deployment Commands" do Coolify

### Instruções para Coolify:

1. **Faça o deploy normalmente** com o `docker-compose.yml`

2. **Configure Post Deployment Commands**: 
   No painel do Coolify, vá em Settings > Advanced e adicione no campo "**Post Deployment Commands**":

```bash
# Aguardar banco estar pronto
sleep 30

# Navegar para diretório da aplicação
cd /var/www/html/laravel-crm

# Executar instalação oficial do Krayin
php artisan krayin-crm:install

# Configurar permissões
chown -R www-data:www-data storage
chmod -R 775 storage

# Limpar cache
php artisan cache:clear
php artisan config:clear

# Criar link simbólico
php artisan storage:link

echo "✅ Krayin CRM configurado com sucesso!"
```

### Opção 2: Setup Manual (Alternativa)
- **Script**: `post-deploy-setup.sh` ou `coolify-post-deploy.sh`
- **Como usar**: Execute após deploy estar funcionando

### Vantagens da Opção 1:
- ✅ **Completamente automático** - Zero intervenção manual
- ✅ **Integrado ao Coolify** - Executa a cada deploy
- ✅ **Segue documentação oficial** - Usa `php artisan krayin-crm:install`
- ✅ **Zero problemas** - Executa no contexto correto do container

## 📋 Instruções de Uso

### Para Coolify (Recomendado):
1. Use o arquivo `docker-compose.yml` atual
2. Configure as variáveis de ambiente
3. Adicione os comandos no "Post Deployment Commands"
4. Faça o deploy - tudo será configurado automaticamente

### Para uso manual:
```bash
# Após deploy estar funcionando
./post-deploy-setup.sh
# OU
./coolify-post-deploy.sh (se executar dentro do container)
```

## 🔧 Configuração de Variáveis

No Coolify, configure essas variáveis obrigatórias:

```env
# Obrigatórias
APP_KEY=base64:sua-chave-aqui
APP_URL=https://seu-dominio.com
DB_PASSWORD=sua-senha-segura
MYSQL_ROOT_PASSWORD=sua-senha-root

# Opcionais
APP_ENV=production
APP_DEBUG=false
APP_TIMEZONE=America/Sao_Paulo
APP_PORT=8082
```

## 🎯 Acesso após instalação:
- **URL**: Seu domínio configurado no Coolify
- **Admin**: admin@example.com
- **Senha**: admin123

## 🔄 Abordagem Alternativa (Para Teste)

Se quiser testar a abordagem oficial exata da documentação:

```bash
# Use o compose oficial
docker-compose -f docker-compose-official.yml up -d

# Execute setup manual
docker exec krayin-app php /var/www/html/laravel-crm/artisan krayin-crm:install
```

## 🆘 Troubleshooting

### Problema: "Database connection failed"
```bash
# Verifique se o banco está rodando
docker exec krayin-mysql mysqladmin ping -h localhost -u krayin -pSUA_SENHA

# Teste conectividade
docker exec krayin-app php -r "new PDO('mysql:host=krayin-db;dbname=krayin', 'krayin', 'SUA_SENHA'); echo 'OK';"
```

### Problema: "Storage permissions"
```bash
# Execute manualmente no container
chown -R www-data:www-data /var/www/html/laravel-crm/storage
chmod -R 775 /var/www/html/laravel-crm/storage
```

## 📚 Documentação Oficial

- [Krayin Documentation](https://devdocs.krayincrm.com/)
- [Docker Installation Guide](https://devdocs.krayincrm.com/2.0/introduction/docker.html)
- [GitHub Repository](https://github.com/krayin/laravel-crm)

## 📁 Arquivos do Projeto

- `docker-compose.yml` - Configuração limpa para Coolify (RECOMENDADO)
- `coolify-commands.txt` - Comandos para Post Deployment Commands do Coolify
- `coolify-post-deploy.sh` - Script otimizado para execução no container
- `post-deploy-setup.sh` - Script para execução externa ao container
- `docker-compose-official.yml` - Configuração oficial da documentação
