#!/usr/bin/env bash
# Rebuild the KitanMonoTermNerd-*.ttf fonts from ../kitan_mono_term.
#
# Requirements:
#   * font-patcher (Nerd Fonts v3.5.1 FontPatcher.zip) and the python3-fontforge
#     bindings (fontforge with python support). If fontforge is not installed
#     system-wide you can point the two variables below at an extracted copy,
#     e.g.:
#       PYTHONPATH=/tmp/ff/root/usr/lib/python3/dist-packages \
#       LD_LIBRARY_PATH=/tmp/ff/root/usr/lib/x86_64-linux-gnu \
#       FONT_PATCHER=/tmp/fp/font-patcher ./nerd-patch.sh
#
# Patching options:
#   --careful  keep the font's own glyphs (braille, powerline, IEC power
#              symbols, progress indicators) and only add the missing icons
#   --complete add the full Nerd Fonts symbol set
#   --single-width-glyphs
#              render every added icon one cell wide (Nerd Fonts "Mono" style),
#              while leaving the font's own wide glyphs untouched
set -euo pipefail

cd "$(dirname "$0")"

FAMILY='Kitan Mono Term Nerd'
FONT_PATCHER=${FONT_PATCHER:-font-patcher}
FONT_PATCHER_PY=${FONT_PATCHER_PY:-python3}
SRC_DIR=${SRC_DIR:-../kitan_mono_term}

PATCHED_DIR=$(mktemp -d)
trap 'rm -rf "$PATCHED_DIR"' EXIT

for font in "$SRC_DIR"/*.ttf; do
    echo "==> patching $(basename "$font")"
    "$FONT_PATCHER_PY" "$FONT_PATCHER" \
        --quiet \
        --careful \
        --complete \
        --single-width-glyphs \
        --outputdir "$PATCHED_DIR" \
        "$font"
done

echo "==> renaming to the $FAMILY family"
"$FONT_PATCHER_PY" rename.py "$PATCHED_DIR" .

echo "==> done"
