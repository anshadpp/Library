
package sample.user.dashboard.util;

import java.util.Base64;

public class Base64Util {
    public static String encode(byte[] data) {
        return Base64.getEncoder().encodeToString(data);
    }

}
