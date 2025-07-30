# Krayin CRM - Alternativas de Inicialização

Este projeto oferece três abordagens diferentes para inicializar o Krayin CRM:

## Opção 1: Script de Inicialização Integrado (Recomendado)
- **Arquivo**: `docker-compose.yml` (atual)
- **Script**: `init-krayin.sh`
- **Como usar**: Execute `docker-compose up -d`
- **Vantagens**: Inicialização automática, sem etapas manuais
- **Desvantagens**: Depende de script externo

## Opção 2: Container de Inicialização Separado
- **Arquivo**: `docker-compose-with-init.yml`
- **Script**: `init-krayin.sh`
- **Como usar**: 
  ```bash
  docker-compose -f docker-compose-with-init.yml up -d
  ```
- **Vantagens**: Separação clara entre inicialização e aplicação
- **Desvantagens**: Mais complexo, requer suporte a `service_completed_successfully`

## Opção 3: Setup Manual/Externo
- **Arquivo**: `docker-compose.yml` (versão simples)
- **Script**: `setup-krayin.sh`
- **Como usar**:
  ```bash
  # 1. Subir os containers
  docker-compose up -d
  
  # 2. Executar setup (após containers estarem rodando)
  ./setup-krayin.sh
  ```
- **Vantagens**: Controle total, debug fácil
- **Desvantagens**: Requer etapa manual

## Para Coolify

Para usar no Coolify, recomendo a **Opção 1** (atual), pois:
- É mais compatível com diferentes versões do Docker Compose
- Não requer comandos adicionais
- Funciona bem com o sistema de deploy do Coolify

## Troubleshooting

Se encontrar problemas com escape de caracteres, use a **Opção 3** temporariamente:

1. Comente o `command:` no docker-compose.yml
2. Faça o deploy normalmente
3. Execute `./setup-krayin.sh` manualmente
4. Depois de verificar que funciona, volte para a Opção 1

## Arquivos

- `init-krayin.sh` - Script de inicialização principal
- `setup-krayin.sh` - Script para execução manual/externa
- `docker-compose.yml` - Configuração atual (Opção 1)
- `docker-compose-with-init.yml` - Configuração com init container (Opção 2)
