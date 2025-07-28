# 🚨 FIX: "no available server" - Krayin CRM

## Problema identificado:
O container `krayin` estava iniciando um MySQL interno (conflito) quando deveria usar apenas o banco externo `krayin-db`.

## Solução implementada:

### 1. Arquivos atualizados:
- ✅ `docker-compose.yml` - Comando customizado para usar apenas Apache
- ✅ `supervisord-web-only.conf` - Configuração do supervisor sem MySQL interno
- ✅ `README.md` - Instruções atualizadas

### 2. No Coolify:
1. **Substitua** o arquivo `docker-compose.yml` pelo novo
2. **Adicione** o arquivo `supervisord-web-only.conf`
3. **Redeploy** o projeto

### 3. O que foi corrigido:
- ❌ **Antes**: Container iniciava Apache + MySQL interno (conflito)
- ✅ **Agora**: Container inicia apenas Apache + conecta ao banco externo

### 4. Verificação:
Após o redeploy, os logs do container `krayin` devem mostrar:
```
Starting Krayin CRM with external database only...
Testing external database connection...
External database connection successful
Setting up permissions...
Starting web server (Apache only)...
```

### 5. Se ainda não funcionar:
1. Remova os volumes no Coolify
2. Certifique-se que as 3 variáveis obrigatórias estão definidas:
   - `APP_KEY`
   - `DB_PASSWORD` 
   - `MYSQL_ROOT_PASSWORD`
3. Redeploy completo

## Status:
🟢 **PRONTO PARA DEPLOY** - Todos os arquivos foram corrigidos
