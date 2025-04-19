#!/bin/bash

# System Update
sudo apt update

# Function to get Ubuntu version
get_ubuntu_version() {
  # Extract Ubuntu version number from /etc/os-release
  version=$(grep "^VERSION=" /etc/os-release | cut -d'"' -f2 | awk '{gsub("\\.", ""); print substr($1,1,4)}')
  echo "$version"
}

# Function to install python3-pip
install_pip() {
  echo "Installing python3-pip..."
  sudo apt install -y python3-pip

  echo "Python3-pip installation completed!"
}

# Function to install python3-venv
install_venv() {
  echo "Installing python3-venv..."
  sudo apt install -y python3-venv

  echo "Python3-venv installation completed!"
}

# Function to install python-poetry
install_poetry() {
  echo "Installing python-poetry..."
  curl -sSL https://install.python-poetry.org | python3 -
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
  poetry config virtualenvs.in-project true

  echo "Poetry installation completed!"
}

# Function to install pyenv
install_pyenv() {
  echo "Installing pyenv..."
  
  sudo apt-get install -y libssl-dev
  curl https://pyenv.run | bash
  echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

  echo "Pyenv installation completed!"
}

# Function to install neovim
install_neovim() {
  echo "Installing neovim..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
  echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc

  echo "NeoVim installation completed!"
}

# Install xclip: A clipboard for Neovim
install_xclip() {
  echo "Installing xclip..."
  sudo apt install -y xclip

  echo "xClip installation completed!"
}

# Install Postman
install_postman() {
  echo "Installing Postman..."

  POSTMAN_URL="https://dl.pstmn.io/download/latest/linux64"
  INSTALL_DIR="/opt/postman"
  TEMP_ARCHIVE="/tmp/postman.tar.gz"
  CURRENT_USER_HOME=$(eval echo ~$SUDO_USER)  # Get the current user's home directory

  # Download the latest version of Postman using curl
  echo "Downloading Postman..."
  curl -L -o "$TEMP_ARCHIVE" "$POSTMAN_URL"

  # Extract Postman archive
  echo "Extracting Postman archive..."
  sudo mkdir -p "$INSTALL_DIR"
  sudo tar -xzf "$TEMP_ARCHIVE" -C "$INSTALL_DIR"

  # Create symlink
  sudo ln -sf "$INSTALL_DIR/Postman/Postman" /usr/bin/postman

  # Create desktop entry in current user's home directory
  echo "[Desktop Entry]
  Encoding=UTF-8
  Name=Postman
  Exec=$INSTALL_DIR/Postman/Postman %U
  Icon=$INSTALL_DIR/Postman/app/resources/app/assets/icon.png
  Terminal=false
  Type=Application
  Categories=Development;" > "$CURRENT_USER_HOME/.local/share/applications/Postman.desktop"

  echo "Postman installation completed!"
}

# Install Brave Browser
install_brave() {
  echo "Installing Brave Browser..."
  sudo apt install -y apt-transport-https curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser

  echo "Brave browser installation completed!"
}

# Install Visual Studio Code
install_vscode() {
  echo "Installing Visual Studio Code..."
  sudo apt-get install -y wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  rm -f packages.microsoft.gpg
  sudo apt install -y apt-transport-https
  sudo apt update
  sudo apt install -y code # or code-insiders

  echo "VSCode installation completed!"
}

# Install Git
install_git() {
  echo "Installing Git..."
  sudo apt install -y git

  echo "Git installation completed!"
}

# Function to install the latest version of Obsidian
install_obsidian() {
  echo "Installing Obsidian..."
  latest_release=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest)
  download_url=$(echo "$latest_release" | grep browser_download_url | grep amd64.deb | cut -d '"' -f 4)
  version_name=$(echo "$latest_release" | grep tag_name | cut -d '"' -f 4)
  wget "$download_url" -O "obsidian-${version_name}-amd64.deb"
  sudo dpkg -i "obsidian-${version_name}-amd64.deb"
  rm "obsidian-${version_name}-amd64.deb"
  
  echo "Obsidian ${version_name} has been installed successfully."
}

# Install Docker
install_docker() {
  echo "Installing Docker..."
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker $USER

  echo "Docker installation completed!"
}

# Function to install Zoom
install_zoom() {
  echo "Installing Zoom..."
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo dpkg -i zoom_amd64.deb
  sudo apt-get install -f
  rm zoom_amd64.deb
  echo "Zoom installation completed!"
}

# Function to install Flameshot
install_flameshot() {
  echo "Installing Flameshot..."
  sudo apt install -y flameshot

  echo "Flameshot installation completed!"
}


install_cuda() {
  echo "Checking Ubuntu version..."
  UBUNTU_VERSION=$(get_ubuntu_version)
  echo "Detected Ubuntu version: $UBUNTU_VERSION"
  
  read -p "Enter the CUDA Toolkit version you want to install (e.g., 12.2.1): " CUDA_VERSION
  read -p "Enter the CUDA Toolkit IP (eg., 555.42.06): " CUDA_TOOLKIT_IP
  
  # Replace the first dot with a dash to get CUDA_DASH_VERSION (e.g., 12.2.1 -> 12-2)
  CUDA_DASH_VERSION=$(echo $CUDA_VERSION | sed 's/\./-/2' | cut -d'.' -f1-2)
  CUDA_LOCAL_VERSION=$(echo $CUDA_VERSION | tr '.' '-' | rev | cut -d'-' -f2- | rev)

  echo "CUDA DASH VERSION: $CUDA_DASH_VERSION"
  echo "CUDA LOCAL VERSION: $CUDA_LOCAL_VERSION" 
  echo "Installing NVIDIA CUDA Toolkit version $CUDA_VERSION for Ubuntu $UBUNTU_VERSION..."
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION}/x86_64/cuda-ubuntu${UBUNTU_VERSION}.pin
  wget https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/cuda-repo-ubuntu${UBUNTU_VERSION}-${CUDA_LOCAL_VERSION}-local_${CUDA_VERSION}-${CUDA_TOOLKIT_IP}-1_amd64.deb
  sudo mv cuda-ubuntu${UBUNTU_VERSION}.pin /etc/apt/preferences.d/cuda-repository-pin-600
  sudo dpkg -i $PWD/cuda-repo-ubuntu${UBUNTU_VERSION}-${CUDA_LOCAL_VERSION}-local_${CUDA_VERSION}-${CUDA_TOOLKIT_IP}-1_amd64.deb
  
  # Assuming CUDA keyring file naming convention
  CUDA_KEYRING_FILE=$(ls /var/cuda-repo-ubuntu${UBUNTU_VERSION}-${CUDA_LOCAL_VERSION}-local/cuda-*-keyring.gpg)
  if [ -f "$CUDA_KEYRING_FILE" ]; then
    sudo cp $CUDA_KEYRING_FILE /usr/share/keyrings/
  else
    echo "Keyring file not found. Verify CUDA installation."
  fi  
  sudo apt-get update
  sudo apt-get -y install cuda-toolkit-${CUDA_LOCAL_VERSION}

  echo "NVIDIA CUDA Toolkit version $CUDA_VERSION installation completed!"
  
  # Add environment variables to .bashrc
  echo "Adding environment variables to .bashrc..."
  echo "export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA_VERSION}/lib64" >> ~/.bashrc
  echo "export CUDA_HOME=/usr/local/cuda-${CUDA_VERSION}" >> ~/.bashrc
  source ~/.bashrc
}

# Function to install Tmux
install_flameshot() {
  echo "Installing Tmux..."
  sudo apt install -y tmux

  echo "Tmux installation completed!"
}


# List of all the packages
packages=(
  "python3-pip,install_pip"
  "python3-venv,install_venv"
  "python-poetry,install_poetry"
  "pyenv,install_pyenv"
  "neovim,install_neovim"
  "xclip,install_xclip"
  "postman,install_postman"
  "brave-browser,install_brave"
  "vscode,install_vscode"
  "git,install_git"
  "obsidian,install_obsidian"
  "docker,install_docker"
  "zoom,install_zoom"
  "flameshot, install_flameshot"
  "cuda,install_cuda"
  "tmux,install_tmux"
)

# Ask user if they want to install all packages
read -p "Do you want to install all packages (python3-pip, python3-venv, python-poetry, pyenv, neovim, xclip, postman, brave-browser, vscode, git, obsidian, docker, zoom, flameshot, cuda)? [y/N]: " install_all

if [[ "$install_all" =~ ^[Yy]$ ]]; then
  # Install all packages together
  for package in "${packages[@]}"; do
    IFS=',' read -r package_name install_function <<< "$package"
    "$install_function"
  done
else
  # Ask individually for each package
  for package in "${packages[@]}"; do
    IFS=',' read -r package_name install_function <<< "$package"
    read -p "Do you want to install $package_name? [y/N]: " install_input
    if [[ "$install_input" =~ ^[Yy]$ ]]; then
      "$install_function"
    fi
  done
fi

echo "Installation complete."

