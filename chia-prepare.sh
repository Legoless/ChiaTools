sudo apt-get update
sudo apt-get upgrade -y

# Checkout the source and install
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest
cd chia-blockchain

sh install.sh

. ./activate

chia init

# Destination dir
DESTINATION_DIR=/mnt/chiadata

sudo mkdir $DESTINATION_DIR
sudo chmod 777 $DESTINATION_DIR

#
# If NVMe exists (Amazon), then prepare dir.
#

if [ -f "/dev/nvme0n1" ]; then
    echo "Detected NVMe Storage. Amazon places ephemeral0 storage at /dev/nvme0n1"
    
    sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
    sudo mount -o discard /dev/nvme0n1 $DESTINATION_DIR
    /dev/nvme0n1 $DESTINATION_DIR ext4 defaults,nofail,discard 0 2
fi

#
# Write tmux script
#

echo '. ./activate' >> automate.sh
echo `chia plots create -k 32 -n 1 -e -r 2 -t $DESTINATION_DIR -d $DESTINATION_DIR -f a246bb245a63442256cff84dff638a9ce54d82e0ad0fc325222420d79a93cb59bb2b5466454f61e487d1067f23b3af0f -p 8bf0193400549b3079902c2be399aad3e2d481a0c1b4dc980f23a6ea9266b028c1838da607859988d91c53c163b1fe6e` >> automate.sh

chmod +x automate.sh

echo `tmux new-session -d -s "PlotSession" './automate.sh'`

#
# Run tmux
#

# mux new-session -d -s "PlotSession" './automate.sh'
