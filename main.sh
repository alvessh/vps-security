#/bin/bash
# alvessh - 20241101

if [ "$EUID" -ne 0 ]; then
    echo "Este script deve ser executado como root. Use 'sudo bash main.sh'."
    exit 1
fi

check_ssh_port() {
    SSH_PORT=$(grep "^Port" /etc/ssh/sshd_config | awk '{print $2}')
    if [ "$SSH_PORT" == "22" ]; then
        echo "[ALERTA]: SSH está configurado para usar a porta padrão (22)."
    else
        echo "[SHOW], SSH está usando uma porta diferente do padrão: $SSH_PORT."
    fi
}

check_ufw_status() {
    UFW_STATUS=$(ufw status | grep -o "Status: active")
    if [ "$UFW_STATUS" == "Status: active" ]; then
        ufw status verbose
        echo "[SHOW] O firewall UFW está ativo."
    else
        echo "[ALERTA]: O firewall UFW está desativado."
    fi
}

security_checkup() {
    echo "Checkup de Segurança:"
    check_ssh_port
    check_ufw_status
    echo "Checkup de segurança concluído."

    show_menu
}

update_system() {
    echo "Verificando e aplicando atualizações..."
    apt update && apt upgrade -y
    echo "Atualizações aplicadas."
}

activate_firewall() {
    echo "Ativando o UFW"
    # ufw default deny incoming
    # ufw default allow outgoing
    ufw enable
    echo "Firewall UFW ativado."

    ufw status verbose
}

change_ssh_port() {
    read -p "Digite a nova porta para o SSH: " NEW_SSH_PORT

    if [[ "$NEW_SSH_PORT" =~ ^[0-9]+$ ]] && [ "$NEW_SSH_PORT" -ge 1024 ] && [ "$NEW_SSH_PORT" -le 39999 ]; then
        # Editando o arquivo sshd_config
        sed -i "s/^#Port 22/Port $NEW_SSH_PORT/" /etc/ssh/sshd_config
        sed -i "s/^Port 22/Port $NEW_SSH_PORT/" /etc/ssh/sshd_config

        ufw allow "$NEW_SSH_PORT"/tcp
        ufw reload

        systemctl restart sshd
        echo "Porta do SSH alterada para $NEW_SSH_PORT e firewall atualizado."
    else
        echo "Porta inválida. Escolha um número entre 1024 e 39999."
    fi
}

show_menu() {
    echo "Selecione uma opção:"
    echo "1) Realizar checkup de segurança"
    echo "2) Atualizar o sistema"
    echo "3) Ativar o firewall UFW"
    echo "4) Alterar a porta do SSH"
    echo "5) Sair"
    read -p "Escolha uma opção: " option

    case $option in
        1)
            security_checkup
            ;;
        2)
            update_system
            ;;
        3)
            activate_firewall
            ;;
        4)
            change_ssh_port
            ;;
        5)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida!"
            show_menu
            ;;
    esac
}

show_menu