# NixOS && MacOS

|              | NixOS         | MacOS         |
| ------------ | ------------- | ------------- |
| Tiling       | Hyprland      | Yabai + skhd  |
| Terminal     | Kitty         | Kitty         |
| App launcher | rofi-wayland  | Raycast       |
| Top bar      | waybar        | sketchybar    |
| IDE          | neovim        | neovim        |
| Font         | Berkeley-mono | Berkeley-mono |

```
ctrl - hjkl : navigate window focus
cmd - hl : navigate workspace focus
cmd - s : app launcher
cmd - q : kitty launch
cmd - c : close window
```

yabai bug fix:
```
rm /tmp/yabai*
yabai --restart-service
```

skhd bug fix:
```
skhd --reload
```
