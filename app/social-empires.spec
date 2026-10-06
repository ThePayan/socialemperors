# -*- mode: python ; coding: utf-8 -*-
#
# PyInstaller spec for the Social Empires desktop app (Ruffle edition).
#
#   pip install -r app/requirements-app.txt
#   pyinstaller app/social-empires.spec --noconfirm
#
# Output: dist/SocialEmpires/ (Windows/Linux folder) or dist/SocialEmpires.app (macOS).
import os
import sys

ROOT = os.path.abspath(os.path.join(SPECPATH, ".."))
NAME = "SocialEmpires"

# Only the game builds offered on the login page are shipped (the full archive is ~230 MB).
GAME_SWFS = [
    "SELoader.swf",
    "SocialEmpires0926bsec_ruffle.swf",  # 0.9.26b patched for Ruffle (see app/swf_patch)
    "SocialEmpires1.1.5sec_ruffle.swf",  # 1.1.5 patched for Ruffle
    "SocialEmpires1.4.07sec.swf",
]

datas = []
for entry in os.listdir(os.path.join(ROOT, "assets")):
    src = os.path.join(ROOT, "assets", entry)
    if entry == "flash" or not os.path.isdir(src):
        continue
    datas.append((src, os.path.join("assets", entry)))
for swf in GAME_SWFS:
    datas.append((os.path.join(ROOT, "assets", "flash", swf), os.path.join("assets", "flash")))
for folder in ("config", "stub", "templates", "villages"):
    datas.append((os.path.join(ROOT, folder), folder))

icon = os.path.join(ROOT, "build", "icon.ico")

a = Analysis(
    [os.path.join(ROOT, "app", "launcher.py")],
    pathex=[ROOT],
    binaries=[],
    datas=datas,
    hiddenimports=["server"],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=["tkinter", "matplotlib", "numpy", "PIL"],
    noarchive=False,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name=NAME,
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=icon,
)

coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=False,
    upx_exclude=[],
    name=NAME,
)

if sys.platform == "darwin":
    app = BUNDLE(
        coll,
        name=NAME + ".app",
        icon=icon,
        bundle_identifier="org.socialemperors.socialempires",
        info_plist={
            "CFBundleDisplayName": "Social Empires",
            "NSHighResolutionCapable": True,
        },
    )
