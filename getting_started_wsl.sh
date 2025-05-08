#!/usr/bin/env bash
set -euo pipefail

# Se vuoi farlo funzionare con qualsiasi utente, usa USER_HOME="$HOME"
USER_HOME=$HOME

echo "=== Installazione non-interattiva di Homebrew ==="
# CI=1 disabilita prompt interattivi, HOMEBREW_NO_ANALYTICS disabilita analytics
HOMEBREW_NO_ANALYTICS=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "=== Configurazione di Homebrew in .bashrc ==="
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${USER_HOME}/.bashrc"

echo "=== Installazione build-essential (non-interattiva) ==="
sudo DEBIAN_FRONTEND=noninteractive apt update --fix-missing
sudo DEBIAN_FRONTEND=noninteractive apt install -y build-essential

echo "=== Ricarica della shell ==="
source "${USER_HOME}/.bashrc"

echo "=== Installazione di GCC via Homebrew ==="
brew install gcc

echo "=== Installazione di asdf ==="
brew install asdf

echo "=== Configurazione di asdf in .bashrc ==="
echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> "${USER_HOME}/.bashrc"
echo '. <(asdf completion bash)' >> "${USER_HOME}/.bashrc"

echo "=== Ricarica della shell ==="
source "${USER_HOME}/.bashrc"

echo "=== Aggiunta del plugin Node.js ad asdf ==="
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

echo "=== Verifica plugin asdf installati ==="
asdf plugin list

echo "=== Installazione dell'ultima versione di Node.js ==="
asdf install nodejs latest

echo "=== Impostazione versione Node.js di default ==="
asdf set -u nodejs latest

echo "=== Abilitazione Corepack e installazione pnpm ==="
asdf exec corepack enable
asdf exec corepack prepare pnpm@latest --activate
asdf reshim nodejs
asdf exec corepack use pnpm@latest-10

echo "=== Controllo pnpm e fallback automatico ==="
if ! asdf exec pnpm --version &>/dev/null; then
  echo "pnpm non trovato, eseguo 'asdf exec pnpm setup'"
  asdf exec pnpm setup
fi

echo "=== Ricarica della shell ==="
source "${USER_HOME}/.bashrc"

echo "=== Installazione typescript ==="
pnpm i -g typescript

echo "=== FINE ==="
