# Ruffle compatibility patch for the game SWFs

The desktop app plays the original game files with [Ruffle](https://ruffle.rs) instead of
Adobe Flash Player. Two differences between Ruffle and Flash Player made the game unplayable
(the tutorial could not be finished and units could not be moved), so the `GUI.GuiManager`
class of the game is recompiled with two small workarounds:

1. **Map stays locked after clicking a button that disappears** (e.g. *Train*).
   The game disables map clicks while the mouse is over the bottom bar and re-enables them on
   `MOUSE_OUT`. When the hovered button is removed from the display list, Flash Player still
   delivers that `MOUSE_OUT`; Ruffle does not, so ground clicks were ignored from then on.
   The patch watches `MOUSE_OVER`/`MOUSE_MOVE` on the stage and runs the bar's own
   `mouseOut` handler as soon as the pointer is over something that is not part of the bar.

2. **Clicking a unit selects the building behind it.**
   While the mouse button is held the game redraws a drag-selection box under the cursor every
   frame. For a simple click that box has zero size; Flash Player does not hit-test it but
   Ruffle does, so the unit received `MOUSE_OUT` and the click fell through to the tile behind.
   The patch makes that tiny box (≤ 3 px, the same threshold the game uses) ignore the mouse.

Nothing else in the game is changed. The original SWFs stay in `assets/flash` (used by the
legacy `/flash.html` page); the server serves `<name>_ruffle.swf` to Ruffle when it exists.

| Game version | Patched file | Source | Diff |
| --- | --- | --- | --- |
| 0.9.26b | `assets/flash/SocialEmpires0926bsec_ruffle.swf` | `GuiManager_0926b.as` | `GuiManager_0926b.diff` |
| 1.1.5 | `assets/flash/SocialEmpires1.1.5sec_ruffle.swf` | `GuiManager_1.1.5.as` | `GuiManager_1.1.5.diff` |

## Rebuilding a patched SWF

The class was decompiled and recompiled with the library of
[JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler) (GPL-3.0),
using `Patch.java` in this folder:

```sh
# build ffdec_lib (or use the lib/ folder of an FFDec release)
git clone --depth 1 https://github.com/jindrapetrik/jpexs-decompiler
cd jpexs-decompiler/libsrc/ffdec_lib
find src -name "*.java" > sources.txt
javac -nowarn -encoding UTF-8 -proc:none -d classes -cp "lib/*" @sources.txt
(cd src && find . -type f ! -name "*.java" -exec cp --parents {} ../classes \;)
cd -

# compile and run the patcher
javac -cp "jpexs-decompiler/libsrc/ffdec_lib/classes:jpexs-decompiler/libsrc/ffdec_lib/lib/*" -d . app/swf_patch/Patch.java
java -cp ".:jpexs-decompiler/libsrc/ffdec_lib/classes:jpexs-decompiler/libsrc/ffdec_lib/lib/*" Patch \
    assets/flash/SocialEmpires0926bsec.swf assets/flash/SocialEmpires0926bsec_ruffle.swf \
    jpexs-decompiler/resources/flashlib/playerglobal32_0.swc \
    GUI.GuiManager=app/swf_patch/GuiManager_0926b.as
```
