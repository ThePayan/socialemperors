import com.jpexs.decompiler.flash.*;
import com.jpexs.decompiler.flash.abc.ScriptPack;
import com.jpexs.decompiler.flash.configuration.Configuration;
import com.jpexs.decompiler.flash.importers.As3ScriptReplacerFactory;
import com.jpexs.decompiler.flash.importers.As3ScriptReplacerInterface;
import java.io.*;
import java.nio.file.*;
import java.util.*;
// usage: Patch in.swf out.swf playerglobal.swc Class.Path=file.as ...
public class Patch {
    public static void main(String[] a) throws Exception {
        Configuration.playerLibLocation.set(a[2]);
        SWF swf = new SWF(new BufferedInputStream(new FileInputStream(a[0])), false);
        As3ScriptReplacerInterface rep = As3ScriptReplacerFactory.createFFDec();
        for (int i = 3; i < a.length; i++) {
            String[] kv = a[i].split("=", 2);
            String text = new String(Files.readAllBytes(Paths.get(kv[1])), "UTF-8");
            ScriptPack found = null;
            for (ScriptPack p : swf.getAS3Packs()) {
                if (p.getClassPath().toString().equals(kv[0])) { found = p; break; }
            }
            if (found == null) { System.err.println("NOT FOUND " + kv[0]); System.exit(2); }
            try {
                found.abc.replaceScriptPack(rep, found, text, new ArrayList<>());
                System.out.println("replaced " + kv[0]);
            } catch (com.jpexs.decompiler.flash.importers.As3ScriptReplaceException e) {
                System.err.println("COMPILE ERROR in " + kv[0] + ": " + e.getExceptionItems());
                System.exit(3);
            }
        }
        try (OutputStream os = new BufferedOutputStream(new FileOutputStream(a[1]))) { swf.saveTo(os); }
        System.out.println("saved " + a[1]);
        System.exit(0);
    }
}
