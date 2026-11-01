#!/usr/bin/env bash
# Instala as configurações deste repositório em ~/.config.
# Arquivos/pastas existentes são movidos para ~/.config-backup-<data> antes.
# Uso: ./install.sh            -> copia os arquivos
#      ./install.sh --link     -> cria links simbólicos (edições ficam no repo)
#      ./install.sh --packages -> instala também os pacotes de packages.txt (pacman)
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
MODE=copy

for arg in "$@"; do
    case "$arg" in
        --link) MODE=link ;;
        --packages) sudo pacman -S --needed - < "$REPO/packages.txt" ;;
        *) echo "Opção desconhecida: $arg" >&2; exit 1 ;;
    esac
done

mkdir -p "$HOME/.config"
for src in "$REPO"/.config/* "$REPO"/.config/fish/config.fish; do
    [ "$src" = "$REPO/.config/fish" ] && continue
    rel="${src#"$REPO"/}"
    dst="$HOME/$rel"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP/$(dirname "$rel")"
        mv "$dst" "$BACKUP/$rel"
    fi
    mkdir -p "$(dirname "$dst")"
    if [ "$MODE" = link ]; then
        ln -s "$src" "$dst"
    else
        cp -a "$src" "$dst"
    fi
    echo "ok: $rel"
done

[ -d "$BACKUP" ] && echo "Backup dos arquivos antigos em: $BACKUP"
echo "Pronto. Ajuste ~/.config/hypr/config/monitors.lua para os monitores deste PC."
