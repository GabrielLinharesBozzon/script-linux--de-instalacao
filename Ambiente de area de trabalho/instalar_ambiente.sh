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

# Atualize o sistema
sudo apt update && sudo apt upgrade -y
check_success "Atualização do sistema"

# Instale pacotes básicos
sudo apt install -y curl gnupg lsb-release software-properties-common
check_success "Pacotes básicos"

# Instale o Docker via Snap
echo "Instalando Docker..."
sudo snap install docker
sudo systemctl start snap.docker.dockerd
sudo systemctl enable snap.docker.dockerd
sudo usermod -aG docker $USER
check_success "Docker via Snap"

# Instale o NVM
echo "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
check_success "Script de instalação do NVM baixado e executado"

# Verificar se o NVM foi instalado corretamente
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    echo "NVM instalado corretamente."
    source "$HOME/.nvm/nvm.sh"
    source ~/.bashrc
    check_success "NVM carregado corretamente"
else
    echo "Erro: NVM não foi instalado corretamente."
    exit 1
fi

# Instale a última versão do Node.js usando o NVM
echo "Instalando Node.js via NVM..."
nvm install node
check_success "Node.js via NVM"

# Instale o Speedtest CLI
echo "Instalando Speedtest CLI..."
sudo apt install -y speedtest-cli
check_success "Speedtest CLI"

# Instale o Nmap
echo "Instalando Nmap..."
sudo apt install -y nmap
check_success "Nmap"

# Instale o Java
echo "Instalando Java..."
sudo apt install -y default-jdk
check_success "Java"

# Instale o Flathub
echo "Instalando Flathub..."
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
check_success "Flathub"

# Instale o Flathub Shop
echo "Instalando Flathub Shop..."
flatpak install flathub com.valvesoftware.Steam -y
check_success "Flathub Shop"

# Instale o GitHub CLI
echo "Instalando GitHub CLI..."
sudo apt install -y gh
check_success "GitHub CLI"

# Instale o Google Chrome
echo "Instalando Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
check_success "Google Chrome"

# Instale o Visual Studio Code
echo "Instalando Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
check_success "Visual Studio Code"

# Finalize
echo "Instalação concluída!"

