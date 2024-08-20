#!/bin/bash

# Função para verificar se o último comando foi bem-sucedido
check_success() {
    if [ $? -eq 0 ]; then
        echo "$1 instalado com sucesso."
    else
        echo "Erro ao instalar $1."
        exit 1
    fi
}

# Função para instalar o Visual Studio Code
install_vscode() {
    echo "Instalando Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
    check_success "Visual Studio Code"
}

# Função para instalar o Android Studio
install_android_studio() {
    echo "Instalando Android Studio..."
    sudo apt update
    sudo apt install -y wget unzip
    wget https://r1---sn-hpa7zn7l.gvt1.com/edgedl/android/studio/ide-zips/2024.0.0.19/android-studio-2024.0.0.19-linux.tar.gz
    sudo tar -xzf android-studio-*-linux.tar.gz -C /opt/
    /opt/android-studio/bin/studio.sh
    check_success "Android Studio"
}

# Função para instalar o PyCharm
install_pycharm() {
    echo "Instalando PyCharm..."
    sudo snap install pycharm-community --classic
    check_success "PyCharm"
}

# Função para instalar o NetBeans via Snap
install_netbeans() {
    echo "Instalando NetBeans..."
    sudo snap install netbeans --classic
    check_success "NetBeans"
}

# Função para instalar o JupyterLab
install_jupyterlab() {
    echo "Instalando JupyterLab..."
    sudo apt update
    sudo apt install -y python3-pip
    pip3 install jupyterlab
    check_success "JupyterLab"
}

# Menu de seleção de software
echo "Selecione o software que deseja instalar:"
echo "1) Visual Studio Code"
echo "2) Android Studio"
echo "3) PyCharm"
echo "4) NetBeans"
echo "5) JupyterLab"
echo "6) Sair"

read -p "Digite o número da sua escolha: " choice

case $choice in
    1)
        install_vscode
        ;;
    2)
        install_android_studio
        ;;
    3)
        install_pycharm
        ;;
    4)
        install_netbeans
        ;;
    5)
        install_jupyterlab
        ;;
    6)
        echo "Saindo do script."
        exit 0
        ;;
    *)
        echo "Opção inválida."
        ;;
esac

echo "Processo concluído!"

