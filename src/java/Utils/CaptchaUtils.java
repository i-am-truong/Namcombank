/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.imageio.ImageIO;

/**
 *
 * @author duong
 */
public class CaptchaUtils {
    public static String generateCaptcha() {
        // Tạo captcha ngẫu nhiên
        String captcha = "";
        for (int i = 0; i < 5; i++) {
            int random = (int) (Math.random() * 36); // Use 36 to include numbers and uppercase letters
            if (random < 10) {
                captcha += random;
            } else {
                captcha += (char) (random - 10 + 'A');
            }

        }
        return captcha;
    }

    public static String createCaptchaBase64Image(String catpchaGenerate) {
        int width = 205;
        int height = 55;
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = bufferedImage.getGraphics();

        g.setColor(Color.LIGHT_GRAY);
        g.fillRect(0, 0, width, height);

        Random random = new Random();
        g.setColor(Color.BLACK);
        for (int i = 0; i < 15; i++) {
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g.drawLine(x1, y1, x2, y2);
        }

        g.setFont(new Font("Arial", Font.BOLD, 40));

        g.setColor(Color.BLACK);
        g.drawString(catpchaGenerate, 20, 35);
        g.dispose();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            ImageIO.write(bufferedImage, "png", baos);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        byte[] imageBytes = baos.toByteArray();
        String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
        return base64Image;
    }

    public void refreshCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String base64Image = (String) session.getAttribute("captchaImage");
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println(base64Image);
        out.print("" + base64Image);
//        out.flush();
    }
}
