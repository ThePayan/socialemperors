# Social Empires desktop app (no Flash Player needed)

A self-contained app: it starts the Social Emperors server and opens the game in its own
window, played with [Ruffle](https://ruffle.rs), a Flash Player emulator written in Rust and
WebAssembly. No Flash Player, no Flash browser, nothing else to install.

## Playing

Download the file for your system from the Releases page:

| System | File | Notes |
| --- | --- | --- |
| Windows 10/11 | `SocialEmpires-windows-setup.exe` | Installer. Windows may say "Windows protected your PC" because the app is not signed: click *More info* → *Run anyway*. |
| Windows (no install) | `SocialEmpires-windows-portable.zip` | Extract and run `SocialEmpires.exe`. |
| macOS (Apple Silicon) | `SocialEmpires-macos.zip` | Extract, then right-click `SocialEmpires.app` → *Open* the first time (the app is not notarized). |
| Linux | `SocialEmpires-linux.tar.gz` | Extract and run `SocialEmpires/SocialEmpires`. |

Your empires are saved in:

- Windows: `%APPDATA%\SocialEmpires\saves`
- macOS: `~/Library/Application Support/SocialEmpires/saves`
- Linux: `~/.local/share/SocialEmpires/saves`

To keep using saves from an older bundle, copy its `saves` folder there, or put a `saves`
folder next to the executable (portable mode). A log is written to `social-empires.log` in
the same folder.

If the computer has no embedded web view (on Windows: the Microsoft Edge WebView2 runtime,
included in Windows 11 and up-to-date Windows 10), the game opens in your web browser instead.

## How it works

- `app/launcher.py` starts the Flask server (`server.py`) on `127.0.0.1:5050` (or a free port)
  and opens it with [pywebview](https://pywebview.flowrl.com/).
- `/play.html` embeds Ruffle (served locally from `templates/ruffle/`). The legacy Flash Player
  page is still available at `/flash.html`.
- Two Ruffle incompatibilities in the game are worked around in a patched copy of the game
  SWF, see [`swf_patch/`](swf_patch/README.md).

## Running from source

```sh
pip install flask jsonpatch pywebview
python app/launcher.py           # own window
SE_BROWSER=1 python app/launcher.py  # use the web browser instead
```

`python server.py` still works as before; then open <http://127.0.0.1:5050/> in any modern
browser (Chrome, Firefox, Edge, Safari).

## Building the app

```sh
pip install -r app/requirements-app.txt
pyinstaller app/social-empires.spec --noconfirm   # -> dist/SocialEmpires
iscc app/installer.iss                            # Windows installer (Inno Setup 6)
```

The GitHub Actions workflow `.github/workflows/build-app.yml` builds all three systems and,
when a tag such as `v0.04a-app1` is pushed, publishes them as a release.

## Credits and licenses

- Social Emperors server: GPL-3.0 (this repository).
- Ruffle: MIT / Apache-2.0, see `templates/ruffle/LICENSE_MIT` and `LICENSE_APACHE`.
- Social Empires game files and artwork belong to Social Point. This is a non-commercial
  preservation project.
