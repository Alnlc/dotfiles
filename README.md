# dotfiles

Configurações do meu desktop Hyprland (CachyOS) com Noctalia.

Inclui: `hypr`, `noctalia`, `kitty`, `alacritty`, `fish`, `btop`, `micro`,
`gtk-3.0`, `gtk-4.0`, `qt6ct`, `uwsm` e `mimeapps.list`.

## Usar em outro PC

```bash
git clone https://github.com/<usuario>/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --packages   # instala os pacotes e copia as configs
```

- `./install.sh` só copia as configs (sem instalar pacotes).
- `./install.sh --link` usa links simbólicos, assim mudanças ficam direto no repositório.
- O que já existir em `~/.config` vai para `~/.config-backup-<data>`.

Depois de instalar, ajuste `~/.config/hypr/config/monitors.lua`
(nomes das saídas em `hyprctl monitors`).

## Atualizar o repositório

```bash
cd ~/dotfiles
cp -a ~/.config/hypr ~/.config/noctalia .config/   # ou use --link e pule este passo
git add -A && git commit -m "Atualiza configs" && git push
```
