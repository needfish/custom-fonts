# Rename the font-patcher output to the Kitan Mono NT family (used by nerd-patch.sh).
import fontforge, os, sys, glob

STYLES = {
    'Regular':    ('Regular',     400),
    'Bold':       ('Bold',        700),
    'Italic':     ('Italic',      400),
    'BoldItalic': ('Bold Italic', 700),
}
FAMILY = 'Kitan Mono NT'
PS = FAMILY.replace(' ', '')
src, dst = sys.argv[1], sys.argv[2]
os.makedirs(dst, exist_ok=True)
for p in sorted(glob.glob(os.path.join(src, '*.ttf'))):
    base = os.path.basename(p)
    key = base.split('-')[-1].replace('.ttf', '')
    sub, weight = STYLES[key]
    full = FAMILY if sub == 'Regular' else FAMILY + ' ' + sub
    ps = PS + '-' + key
    f = fontforge.open(p)
    f.familyname = FAMILY
    f.fullname = full
    f.fontname = ps
    f.weight = sub.replace('Italic', '').strip() or 'Regular'
    f.os2_weight = weight
    def setname(name, value):
        for lang in set(n[0] for n in f.sfnt_names):
            f.appendSFNTName(lang, name, value)
    setname('Family', FAMILY)
    setname('SubFamily', sub)
    setname('Preferred Family', FAMILY)
    setname('Preferred Styles', sub)
    setname('Fullname', full)
    setname('PostScriptName', ps)
    setname('Compatible Full', full)
    f.sfntRevision = None
    out = os.path.join(dst, PS + '-' + key + '.ttf')
    f.generate(out, flags=('opentype',))
    print(out)
    f.close()
