# Update repositories
sudo apt-get update
if [ "$?" != "0" ]; then
	(>&2 echo "[ERROR] Cannot update repositories")
	exit 1
fi

# Install dependencies
echo "[INFO] Installing dependencies..."
sudo apt-get install git
if [ "$?" != "0" ]; then
	(>&2 echo "[ERROR] Cannot install git")
	exit 1
fi
sudo apt-get install build-essential cmake libboost-all-dev miniupnpc libunbound-dev graphviz doxygen libssl-dev
if [ "$?" != "0" ]; then
	(>&2 echo "[ERROR] Cannot install Monero dependencies")
	exit 1
fi

# Install Monaro
echo "[INFO] Installing Monero from source..."
mkdir -p ~/.monero
git clone https://github.com/monero-project/bitmonero.git ~/.monero/git
if [ "$?" != "0" ]; then
	(>&2 echo "[ERROR] Cannot install Monaro from source")
	exit 1
fi

# Compile Monaro
echo "[INFO] Compiling Monero"
make -C ~/.monero/git
if [ "$?" != "0" ]; then
	(>&2 echo "[ERROR] Cannot compile Monero from sources")
	exit 1
fi
mkdir ~/.monero/data
mv ~/.monero/git/build/release/bin/* ~/.monero/data/
if [ "$?" != "0" ]; then
	(>&2 echo "[ERROR] Cannot move binaries from Monero into $HOME/.monero/data directory")
	exit 1
fi

echo "[INFO] Installation completed."
