package sample.user.dashboard.util;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;


public class WhatsappUtil {
    public static void sendMessage(String to, String body) throws AWTException, InterruptedException {
    			StringSelection stringSelection = new StringSelection(body);
    			Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
    			clipboard.setContents(stringSelection, null);
    			
    			Thread.sleep( 3000);
    			
    			Robot robot = new Robot();
    			robot.keyPress(KeyEvent.VK_CONTROL);
    			robot.keyPress(KeyEvent.VK_V);
    			
    			robot.keyRelease(KeyEvent.VK_CONTROL);
    			robot.keyRelease(KeyEvent.VK_V);

    			
    			robot.keyPress(KeyEvent.VK_ENTER);
    			robot.keyRelease(KeyEvent.VK_ENTER);
    			
    			Thread.sleep(1000);
    }
}
