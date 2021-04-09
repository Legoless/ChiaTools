sudo apt-get update
sudo apt-get upgrade -y

# Checkout the source and install
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest
cd chia-blockchain

sh install.sh

. ./activate

chia init
