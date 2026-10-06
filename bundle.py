import sys
import os

# Bundled data (extracted to a temp dir)

TMP_BUNDLED_DIR = sys._MEIPASS if getattr(sys, 'frozen', None) else "."

ASSETS_DIR = os.path.join(TMP_BUNDLED_DIR, "assets")
STUB_DIR = os.path.join(TMP_BUNDLED_DIR, "stub")
TEMPLATES_DIR = os.path.join(TMP_BUNDLED_DIR, "templates")
VILLAGES_DIR = os.path.join(TMP_BUNDLED_DIR, "villages")
QUESTS_DIR = os.path.join(VILLAGES_DIR, "quests")
CONFIG_DIR = os.path.join(TMP_BUNDLED_DIR, "config")
CONFIG_PATCH_DIR = os.path.join(CONFIG_DIR, "patch")

# Not bundled data (saves, mods, downloaded assets)

def _user_data_dir() -> str:
    # The packaged app may be installed somewhere read-only (Program Files, a macOS .app),
    # so player data goes to the usual per-user folder.
    if os.name == "nt":
        root = os.environ.get("APPDATA") or os.path.expanduser("~")
    elif sys.platform == "darwin":
        root = os.path.expanduser("~/Library/Application Support")
    else:
        root = os.environ.get("XDG_DATA_HOME") or os.path.expanduser("~/.local/share")
    return os.path.join(root, "SocialEmpires")

if os.environ.get("SE_DATA_DIR"):
    BASE_DIR = os.environ["SE_DATA_DIR"]
elif getattr(sys, 'frozen', None):
    # Portable mode: a "saves" folder next to the executable (old bundles) keeps working.
    EXE_DIR = os.path.dirname(os.path.abspath(sys.executable))
    BASE_DIR = EXE_DIR if os.path.isdir(os.path.join(EXE_DIR, "saves")) else _user_data_dir()
else:
    BASE_DIR = "."

os.makedirs(BASE_DIR, exist_ok=True)

MODS_DIR = os.path.join(BASE_DIR, "mods")
SAVES_DIR = os.path.join(BASE_DIR, "saves")
