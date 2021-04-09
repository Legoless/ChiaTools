sudo apt-get update

# DO has an older image, we need to force upgrade to get through automatically.
sudo apt-get upgrade -y -o Dpkg::Options::="--force-confold" --force-yes

# Install NodeJS 15
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs

# Checkout the source and install
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest
cd chia-blockchain

sh install.sh

. ./activate

chia init
