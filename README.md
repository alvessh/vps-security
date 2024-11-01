# VPS Security Checkup and Enhancement

Este repositório contém scripts para realizar checkups de segurança e aplicar melhorias em servidores VPS Linux. Atualmente, é focado em servidores Ubuntu, ajudando a identificar e corrigir configurações vulneráveis comuns, como portas de SSH e firewall, além de facilitar atualizações de segurança.

## Funcionalidades

- **Checkup de segurança**: Verifica o status da porta SSH, do firewall (UFW) e informa possíveis vulnerabilidades sem realizar alterações automáticas.
- **Atualização do sistema**: Permite ao usuário instalar atualizações de segurança para manter o sistema atualizado.
- **Ativação do firewall**: Configura e ativa o firewall UFW com regras de segurança padrão, bloqueando conexões de entrada e permitindo conexões de saída.
- **Alteração da porta SSH**: Oferece ao usuário a opção de mudar a porta de SSH para uma não padrão, ajustando automaticamente as regras do firewall para a nova porta.

## Pré-requisitos

- Este script é projetado para sistemas operacionais baseados em **Ubuntu**.
- O script deve ser executado com permissões de **root**.

## Uso

1. Clone este repositório:
   ```bash
   wget https://raw.githubusercontent.com/alvessh/vps-security/refs/heads/main/main.sh && sudo bash main.sh

   ou 

   curl -o main.sh https://raw.githubusercontent.com/alvessh/vps-security/refs/heads/main/main.sh && sudo bash main.sh
   ```

## Funcionalidades Futuras

- Compatibilidade com outras distribuições Linux além do Ubuntu.
- Implementação de ferramentas adicionais de segurança, como **fail2ban** para proteção contra tentativas de login indesejadas.
- Auditoria automatizada de logs para identificação de atividades suspeitas.
- Relatórios detalhados de segurança e sugestões de melhorias com base nas configurações do servidor.

## Contribuição

Contribuições são bem-vindas! Se você tiver sugestões de funcionalidades, melhorias ou correções, abra uma issue ou envie um pull request. Sua ajuda é fundamental para tornar este projeto ainda mais útil para a comunidade!

---

Este repositório faz parte de uma iniciativa para simplificar a segurança de VPS e proporcionar uma camada adicional de proteção para administradores de sistemas.
