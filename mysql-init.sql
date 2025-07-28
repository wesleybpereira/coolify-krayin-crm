-- Inicialização do banco de dados Krayin CRM
-- Este script garante que o usuário e banco sejam criados corretamente

-- Criar o banco de dados com charset correto
CREATE DATABASE IF NOT EXISTS krayin 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

-- Usar o banco de dados
USE krayin;

-- Remover usuário se já existir (para recriar com permissões corretas)
DROP USER IF EXISTS 'krayin'@'%';
DROP USER IF EXISTS 'krayin'@'localhost';

-- Criar o usuário krayin com senha
CREATE USER 'krayin'@'%' IDENTIFIED BY 'pefvon-wuMcoz-8qupqe';
CREATE USER 'krayin'@'localhost' IDENTIFIED BY 'pefvon-wuMcoz-8qupqe';

-- Conceder todas as permissões no banco krayin
GRANT ALL PRIVILEGES ON krayin.* TO 'krayin'@'%';
GRANT ALL PRIVILEGES ON krayin.* TO 'krayin'@'localhost';

-- Garantir que o usuário possa se conectar
GRANT USAGE ON *.* TO 'krayin'@'%';
GRANT USAGE ON *.* TO 'krayin'@'localhost';

-- Aplicar as mudanças
FLUSH PRIVILEGES;

-- Verificar se o usuário foi criado corretamente
SELECT 'User krayin created successfully' as status;
