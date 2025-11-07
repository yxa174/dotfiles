#!/usr/bin/env bash
set -euo pipefail

# директория, где лежит этот скрипт
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Создаём симлинк для .vimrc (относительно каталога dotfiles)
ln -sf "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"

# Устанавливаем vim-plug и плагины — только если скрипт существует
if [ -x "$SCRIPT_DIR/vim-plug-install.sh" ]; then
  echo "Запускаю $SCRIPT_DIR/vim-plug-install.sh"
  bash "$SCRIPT_DIR/vim-plug-install.sh"
elif [ -f "$SCRIPT_DIR/vim-plug-install.sh" ]; then
  echo "Файл найден, делаю исполняемым и запускаю"
  chmod +x "$SCRIPT_DIR/vim-plug-install.sh"
  bash "$SCRIPT_DIR/vim-plug-install.sh"
else
  echo "Warning: vim-plug-install.sh не найден в $SCRIPT_DIR — пропускаю установку vim-plug"
fi

# Создаём необходимые директории
mkdir -p "$HOME/.vim/backups" "$HOME/.vim/swaps" "$HOME/.vim/undos"

echo "install.sh: готово"
