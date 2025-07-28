# 🚨 FIX: "no available server" - Krayin CRM

## Problema identificado:
O container `krayin` estava iniciando um MySQL interno (conflito) quando deveria usar apenas o banco externo `krayin-db`.

## Solução implementada:

### 1. Arquivos atualizados:
- ✅ `docker-compose.yml` - Comando customizado para desabilitar MySQL interno via supervisorctl
- ✅ `README.md` - Instruções atualizadas

### 2. No Coolify:
1. **Substitua** o arquivo `docker-compose.yml` pelo novo
2. **Redeploy** o projeto (não precisa mais do arquivo supervisord-web-only.conf)

### 3. O que foi corrigido:
- ❌ **Antes**: Container iniciava Apache + MySQL interno (conflito)
- ✅ **Agora**: Container inicia apenas Apache + conecta ao banco externo

### 4. Verificação:
Após o redeploy, os logs do container `krayin` devem mostrar:
```
Starting Krayin CRM with external database only...
Waiting for external database...
Testing external database connection...
External database connection successful
Setting up permissions...
Starting Apache directly without supervisor...
```

### 🚨 **Atualizações importantes:**
- **v1**: Tentativa com supervisord-web-only.conf (erro de mount)
- **v2**: Uso de supervisorctl stop mysql (MySQL ainda iniciava)
- **v3**: ✅ **ATUAL** - Apache direto sem supervisor (solução final)

### 5. Se ainda não funcionar:
1. Remova os volumes no Coolify
2. Certifique-se que as 3 variáveis obrigatórias estão definidas:
   - `APP_KEY`
   - `DB_PASSWORD` 
   - `MYSQL_ROOT_PASSWORD`
3. Redeploy completo

## Status:
🟢 **PRONTO PARA DEPLOY** - Todos os arquivos foram corrigidos
