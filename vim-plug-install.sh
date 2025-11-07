#!/usr/bin/env bash
set -euo pipefail

LOGDIR="${TMPDIR:-/tmp}/dotfiles-logs"
mkdir -p "$LOGDIR"
LOGFILE="$LOGDIR/vim-plug-install.log"

echo "vim-plug-install.sh: start at $(date)" > "$LOGFILE"

# helper: run a command, log and return status
run_and_log() {
  echo "+ $*" >> "$LOGFILE"
  if "$@" >> "$LOGFILE" 2>&1; then
    echo "OK: $*" >> "$LOGFILE"
    return 0
  else
    local rc=$?
    echo "FAIL($rc): $*" >> "$LOGFILE"
    return $rc
  fi
}

# choose downloader
download() {
  local url="$1"
  local dest="$2"
  if command -v curl >/dev/null 2>&1; then
    run_and_log curl -fSL --retry 3 --retry-delay 2 --retry-connrefused -o "$dest" "$url"
  elif command -v wget >/dev/null 2>&1; then
    run_and_log wget -q -O "$dest" "$url"
  else
    echo "No curl or wget available" >> "$LOGFILE"
    return 2
  fi
}

# target paths
VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# prefer neovim if available
if command -v nvim >/dev/null 2>&1; then
  echo "Detected neovim" >> "$LOGFILE"
  DEST="$HOME/.local/share/nvim/site/autoload/plug.vim"
  INSTALL_CMD=(nvim --headless +PlugInstall +qall)
elif command -v vim >/dev/null 2>&1; then
  echo "Detected vim" >> "$LOGFILE"
  DEST="$HOME/.vim/autoload/plug.vim"
  # use -u to load user's vimrc; -E -s for silent
  INSTALL_CMD=(vim -u "$HOME/.vimrc" -E -s -c "PlugInstall --sync" -c "qa")
else
  echo "No vim or nvim found; skipping plug.vim installation" >> "$LOGFILE"
  echo "vim-plug-install.sh: finished (no editor)" >> "$LOGFILE"
  exit 0
fi

mkdir -p "$(dirname "$DEST")"

# download plug.vim
if download "$VIM_PLUG_URL" "$DEST"; then
  echo "Downloaded plug.vim -> $DEST" >> "$LOGFILE"
else
  echo "Failed to download plug.vim; see $LOGFILE" >> "$LOGFILE"
  # don't fail hard; return non-zero so parent can decide. Exit 1.
  echo "vim-plug-install.sh: finished with errors" >> "$LOGFILE"
  exit 1
fi

# Run plugin install (best-effort). Capture exit code.
if "${INSTALL_CMD[@]}" >> "$LOGFILE" 2>&1; then
  echo "PlugInstall succeeded" >> "$LOGFILE"
  echo "vim-plug-install.sh: finished successfully at $(date)" >> "$LOGFILE"
  exit 0
else
  local_rc=$?
  echo "PlugInstall failed with code $local_rc; see $LOGFILE" >> "$LOGFILE"
  echo "vim-plug-install.sh: finished with errors at $(date)" >> "$LOGFILE"
  exit $local_rc
fi
