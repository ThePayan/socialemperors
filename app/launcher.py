"""
Social Empires desktop launcher.

Starts the local game server and opens the game in its own window. The game runs
on Ruffle (a Flash Player emulator written in Rust/WebAssembly), so no Flash Player
or Flash-enabled browser is needed.

If no embedded web view is available on this computer, the game opens in the
default web browser instead.
"""
import os
import socket
import sys
import threading
import time
import traceback
import webbrowser

APP_NAME = "Social Empires"
HOST = "127.0.0.1"
PREFERRED_PORT = 5050


def _data_dir() -> str:
    # Keep in sync with bundle.py
    if os.environ.get("SE_DATA_DIR"):
        return os.environ["SE_DATA_DIR"]
    if os.name == "nt":
        root = os.environ.get("APPDATA") or os.path.expanduser("~")
    elif sys.platform == "darwin":
        root = os.path.expanduser("~/Library/Application Support")
    else:
        root = os.environ.get("XDG_DATA_HOME") or os.path.expanduser("~/.local/share")
    return os.path.join(root, "SocialEmpires")


def _setup_logging() -> str:
    """Windowed builds have no console: send output to a log file."""
    log_dir = _data_dir()
    os.makedirs(log_dir, exist_ok=True)
    log_path = os.path.join(log_dir, "social-empires.log")
    if sys.stdout is None or sys.stderr is None or getattr(sys, "frozen", False):
        log = open(log_path, "w", encoding="utf-8", buffering=1)
        sys.stdout = log
        sys.stderr = log
    return log_path


def _port_is_free(port: int) -> bool:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try:
            s.bind((HOST, port))
            return True
        except OSError:
            return False


def _pick_port() -> int:
    if os.environ.get("SE_PORT"):
        return int(os.environ["SE_PORT"])
    if _port_is_free(PREFERRED_PORT):
        return PREFERRED_PORT
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, 0))
        return s.getsockname()[1]


def _wait_for_server(port: int, timeout: float = 60.0) -> bool:
    deadline = time.time() + timeout
    while time.time() < deadline:
        try:
            with socket.create_connection((HOST, port), timeout=1):
                return True
        except OSError:
            time.sleep(0.2)
    return False


def _show_error(message: str) -> None:
    print(message)
    try:
        if os.name == "nt":
            import ctypes
            ctypes.windll.user32.MessageBoxW(None, message, APP_NAME, 0x10)
    except Exception:
        pass


def main() -> None:
    log_path = _setup_logging()
    port = _pick_port()
    os.environ["SE_HOST"] = HOST
    os.environ["SE_PORT"] = str(port)

    # The game server lives one folder up (repository root) when running from source.
    if not getattr(sys, "frozen", False):
        sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
        os.chdir(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

    try:
        import server  # loads config and saves
    except Exception:
        _show_error("Social Empires could not start.\n\n" + traceback.format_exc() + "\nLog: " + log_path)
        sys.exit(1)

    threading.Thread(target=server.run, name="game-server", daemon=True).start()
    if not _wait_for_server(port):
        _show_error("The game server did not start. See the log:\n" + log_path)
        sys.exit(1)

    url = f"http://{HOST}:{port}/"
    print(f" [+] Game running at {url}")

    if os.environ.get("SE_BROWSER") != "1":
        try:
            import webview
            gui = None
            if os.name == "nt":
                # pywebview silently falls back to Internet Explorer (MSHTML) when the Edge
                # WebView2 runtime is missing, and Ruffle cannot run there.
                from webview.platforms import winforms
                if not winforms.is_chromium:
                    raise RuntimeError("Microsoft Edge WebView2 runtime not found")
                gui = "edgechromium"
            elif sys.platform.startswith("linux"):
                gui = "qt"
            webview.create_window(APP_NAME, url, width=1000, height=820, min_size=(640, 540), background_color="#2f4a14")
            webview.start(gui=gui, private_mode=False)
            return  # window closed: quit
        except Exception:
            print(" [!] Embedded window not available, using the web browser instead:")
            traceback.print_exc()

    webbrowser.open(url)
    if os.name == "nt" and getattr(sys, "frozen", False):
        # No console in the Windows build: this dialog keeps the server alive until it is closed.
        import ctypes
        ctypes.windll.user32.MessageBoxW(
            None,
            f"Social Empires is running in your web browser:\n{url}\n\nPress OK to close the game.",
            APP_NAME, 0x40)
        return
    print(" [+] Close this program to stop the game server.")
    try:
        while True:
            time.sleep(3600)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
