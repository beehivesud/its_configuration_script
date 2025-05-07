#!/usr/bin/env bash
set -euo pipefail

# Variabile home (modifica se necessario)
USER_HOME="$HOME"

echo "=== Installazione di Homebrew ==="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "=== Configurazione di Homebrew in .bashrc ==="
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${USER_HOME}/.bashrc"
# Applica subito la configurazione
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "=== Installazione build-essential (prima volta) ==="
sudo apt-get install -y build-essential

echo "=== Aggiornamento apt ==="
sudo apt-get update

echo "=== Installazione build-essential (seconda volta) ==="
sudo apt-get install -y build-essential

echo "=== Installazione di GCC via Homebrew ==="
brew install gcc

echo "=== Installazione di asdf ==="
brew install asdf

echo "=== Aggiunta del plugin nodejs ad asdf ==="
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

echo "=== Verifica plugin asdf installati ==="
asdf plugin list

echo "=== Installazione dell'ultima versione di Node.js ==="
asdf install nodejs latest

echo "=== Impostazione versione Node.js di default ==="
asdf set -u nodejs 23.11.0

echo "=== Abilitazione Corepack e installazione pnpm ==="
asdf exec corepack enable
asdf exec corepack prepare pnpm@latest --activate

echo "=== Rigenerazione shim di Node.js ==="
asdf reshim nodejs

echo "=== Selezione pnpm@latest-10 come gestore di pacchetti ==="
asdf exec corepack use pnpm@latest-10

echo "=== (Ripetizione impostazione versione Node.js) ==="
asdf global nodejs 23.11.0

echo "=== In caso di errori con pnpm: tentativo di setup ==="
if ! asdf exec pnpm --version &>/dev/null; then
  echo "pnpm non trovato: eseguo 'asdf exec pnpm setup'"
  asdf exec pnpm setup
fi

echo "=== Ricarica della shell ==="
source "${USER_HOME}/.bashrc"

echo "=== FINE ==="
