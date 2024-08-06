package sample.captcha;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@WebServlet("/captcha")
public class CaptchaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int width = 150;
        int height = 50;
        
        char data[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = bufferedImage.createGraphics();

        Font font = new Font("Georgia", Font.BOLD, 18);
        g2d.setFont(font);

        RenderingHints rh = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        rh.put(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g2d.setRenderingHints(rh);

        GradientPaint gp = new GradientPaint(0, 0, Color.red, 0, height / 2, Color.black, true);
        g2d.setPaint(gp);
        g2d.fillRect(0, 0, width, height);

        g2d.setColor(new Color(255, 153, 0));

        Random r = new Random();
        StringBuilder captcha = new StringBuilder();

        // Generate a random CAPTCHA string with a mix of letters and numbers
        for (int i = 0; i < 6; i++) { // Adjust length of CAPTCHA as needed
            int index = r.nextInt(data.length);
            captcha.append(data[index]);
        }

        request.getSession().setAttribute("captcha", captcha.toString());

        int x = 10; // Start position of the first character
        int y = 25; // Base position for the y-axis

        for (int i = 0; i < captcha.length(); i++) {
            x += 15 + (r.nextInt(10)); // Randomize x position slightly
            y = 25 + r.nextInt(10) - 5; // Randomize y position slightly
            g2d.drawChars(captcha.toString().toCharArray(), i, 1, x, y);
        }

        g2d.dispose();

        response.setContentType("image/png");
        try {
            ImageIO.write(bufferedImage, "png", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
