# Krayin CRM - Instalação no Coolify (Abordagem Oficial)

Baseado na [documentação oficial do Krayin](https://devdocs.krayincrm.com/2.0/introduction/docker.html), este projeto oferece duas abordagens para instalação:

## 🚀 Abordagem Recomendada (Oficial)

### Opção 1: Deploy Simples + Setup Manual
- **Arquivo**: `docker-compose.yml` (versão limpa)
- **Pós-instalação**: `post-deploy-setup.sh`
- **Como usar**:
  1. Faça deploy no Coolify normalmente
  2. Após deploy estar funcionando, execute: `./post-deploy-setup.sh`

### Vantagens:
- ✅ Segue exatamente a documentação oficial do Krayin
- ✅ Zero problemas de escape no YAML
- ✅ Compatível com qualquer versão do Docker/Coolify
- ✅ Fácil debug e troubleshooting
- ✅ Usa o comando oficial: `php artisan krayin-crm:install`

## 📋 Instruções de Uso

### 1. Deploy no Coolify:
- Use o arquivo `docker-compose.yml` atual (versão limpa)
- Configure as variáveis de ambiente no Coolify
- Faça o deploy normalmente

### 2. Após Deploy:
```bash
# Execute o script de setup (uma única vez)
./post-deploy-setup.sh
```

### 3. Acesso:
- **URL**: Seu domínio configurado no Coolify
- **Admin**: admin@example.com
- **Senha**: admin123

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
# Execute manualmente
docker exec krayin-app chown -R www-data:www-data /var/www/html/laravel-crm/storage
docker exec krayin-app chmod -R 775 /var/www/html/laravel-crm/storage
```

## 📚 Documentação Oficial

- [Krayin Documentation](https://devdocs.krayincrm.com/)
- [Docker Installation Guide](https://devdocs.krayincrm.com/2.0/introduction/docker.html)
- [GitHub Repository](https://github.com/krayin/laravel-crm)

## 📁 Arquivos do Projeto

- `docker-compose.yml` - Configuração limpa para Coolify (RECOMENDADO)
- `docker-compose-official.yml` - Configuração oficial exata da documentação
- `post-deploy-setup.sh` - Script de setup pós-deploy
- `setup-krayin.sh` - Script de setup alternativo
- `init-krayin.sh` - Script de inicialização (não usado na abordagem atual)
