# Kitan Mono Term Nerd

`Kitan Mono Term` (custom Iosevka build, see `../private-build-plans.toml`)
patched with the [Nerd Fonts](https://www.nerdfonts.com) icon set.

| File | Family | Style |
| --- | --- | --- |
| `KitanMonoTermNerd-Regular.ttf` | `Kitan Mono Term Nerd` | Regular |
| `KitanMonoTermNerd-Bold.ttf` | `Kitan Mono Term Nerd` | Bold |
| `KitanMonoTermNerd-Italic.ttf` | `Kitan Mono Term Nerd` | Italic |
| `KitanMonoTermNerd-BoldItalic.ttf` | `Kitan Mono Term Nerd` | Bold Italic |

Built with Nerd Fonts **v3.5.1** and these font-patcher options:

```
font-patcher --careful --complete --single-width-glyphs <font>
```

* `--careful` keeps the font's own braille, powerline, IEC power symbols and
  progress-indicator glyphs (only missing icons are added).
* `--complete` adds the full Nerd Fonts symbol set (~10.5k glyphs per style).
* `--single-width-glyphs` draws every icon in a single 576-unit cell, so nothing
  shifts in the terminal, while the font's native wide glyphs stay wide.

The resulting family name/suffix from font-patcher is normalised to
`Kitan Mono Term Nerd` by `rename.py` (the PostScript name stays
space-free: `KitanMonoTermNerd-<style>`).

## Rebuild

```sh
cd kitan_mono_term_nerd
FONT_PATCHER=/path/to/font-patcher \
PYTHONPATH=/path/to/python3-fontforge \
LD_LIBRARY_PATH=/path/to/libfontforge \
./nerd-patch.sh
```

## Install

```sh
mkdir -p ~/.local/share/fonts
cp KitanMonoTermNerd-*.ttf ~/.local/share/fonts/
fc-cache -f
```

## License

Kitan Mono Term is an Iosevka-derived font and stays under the SIL Open Font
License 1.1 (`LICENSE.txt`). The added Nerd Fonts glyphs come from
[ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) and keep their
respective upstream licenses.
