# Krayin CRM - Coolify Deploy Guide

## 🚀 Deploy Simplificado

### Variáveis de Ambiente Obrigatórias (Coolify):

```env
# === OBRIGATÓRIAS ===
APP_KEY=base64:SUA_CHAVE_LARAVEL_AQUI_32_CARACTERES=
APP_URL=https://seu-dominio.com
DB_PASSWORD=SuaSenhaSegura123
MYSQL_ROOT_PASSWORD=OutraSenhaRoot456

# === OPCIONAIS ===
APP_ENV=production
APP_DEBUG=false
APP_PORT=8082
APP_TIMEZONE=America/Sao_Paulo
```

### 🔑 Credenciais Padrão:
- **Email**: `admin@example.com`
- **Senha**: `admin123`

### 🌐 API Endpoints:
- **Base URL**: `https://seu-dominio.com/api/v1/`
- **Autenticação**: Laravel Passport (OAuth2)

### 📋 Passos para Deploy:

1. **Configure as 4 variáveis obrigatórias** no Coolify
2. **Deploy** - primeira instalação cria usuário admin automaticamente
3. **Login** com credenciais padrão
4. **API** está configurada automaticamente

### 🔄 Redeploy:
- ✅ **Dados preservados** - volumes persistentes
- ✅ **Usuários mantidos** - não executa seeders novamente
- ✅ **API funcional** - configuração mantida

### 🛠️ Troubleshooting:
- **Erro de login**: Aguarde 2-3 minutos após deploy
- **API não funciona**: Verifique se APP_URL está correto
- **Gateway Timeout**: Aguarde até 3 minutos para inicialização completa

### 📚 Documentação:
- Krayin: https://devdocs.krayincrm.com/
- API: https://devdocs.krayincrm.com/1.x/api/
