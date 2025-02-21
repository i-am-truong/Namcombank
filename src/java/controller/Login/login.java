package controller.Login;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import context.CustomerDAO;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.Instant;
import model.Customer;

public class login extends HttpServlet {

    private static final int MAX_ATTEMPTS = 3;
    private static final int LOCK_TIME_SECONDS = 60;
    private static final Map<String, Instant> lockedAccounts = new HashMap<>();
    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = "http://localhost:9999/Namcombank/login";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code != null) {
            handleGoogleLogin(request, response, code);
            return;
        }

        Cookie arr[] = request.getCookies();
        if (arr != null) {
            for (Cookie o : arr) {
                if (o.getName().equals("username")) {
                    request.setAttribute("username", o.getValue());
                }
                if (o.getName().equals("password")) {
                    request.setAttribute("password", o.getValue());
                }
            }
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
        } else {
            response.sendRedirect("Home");
        }
    }

    private void handleGoogleLogin(HttpServletRequest request, HttpServletResponse response, String code)
            throws IOException, ServletException {
        String tokenUrl = "https://oauth2.googleapis.com/token";
        String params = "code=" + code + "&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&redirect_uri=" + REDIRECT_URI + "&grant_type=authorization_code";
        String tokenResponse = sendPostRequest(tokenUrl, params);

        JsonObject tokenJson = JsonParser.parseString(tokenResponse).getAsJsonObject();
        String accessToken = tokenJson.get("access_token").getAsString();

        String userInfoUrl = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken;
        String userInfoResponse = sendGetRequest(userInfoUrl);

        JsonObject userJson = JsonParser.parseString(userInfoResponse).getAsJsonObject();
        String email = userJson.has("email") ? userJson.get("email").getAsString() : null;
        String fullname = userJson.has("name") ? userJson.get("name").getAsString() : null;

        CustomerDAO cdao = new CustomerDAO();
        Customer customer = cdao.getCustomerByEmail(email);

        if (customer == null) {
            // Gán giá trị mặc định nếu không có dữ liệu từ Google
            String address = ""; // Hoặc lấy từ Google nếu có
            String phonenumber = ""; // Mặc định nếu không có số điện thoại
            Boolean gender = true; // Mặc định "Nam" (có thể đổi thành `false` nếu cần)
            String dob = ""; // Mặc định nếu không có ngày sinh
            String avatar = ""; // Avatar mặc định nếu không có hình

            // Nếu Google API có các giá trị này, lấy dữ liệu từ JSON
            if (userJson.has("gender")) {
                gender = userJson.get("gender").getAsString().equalsIgnoreCase("male");
            }
            if (userJson.has("birthday")) {
                dob = userJson.get("birthday").getAsString();
            }
            if (userJson.has("picture")) {
                avatar = userJson.get("picture").getAsString();
            }

            // Gọi phương thức với đầy đủ tham số
            customer = cdao.createCustomer(fullname, email, address, phonenumber, gender, dob, avatar);
        }

        // 🔹 Lấy đầy đủ thông tin user từ database
        customer = cdao.getCustomerByEmail(email);

        // 🔹 Kiểm tra tài khoản có bị khóa không
        if (customer.getActive() == 0) {
            request.setAttribute("err", "Your account has been blocked!");
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }

        // 🔹 Lấy số dư tài khoản
        double balance = cdao.getBalanceByCId(customer);

        // 🔹 Lưu thông tin vào session
        HttpSession session = request.getSession();
        session.setAttribute("customer", customer);
        session.setAttribute("customer_id", customer.getCustomerId());
        session.setAttribute("balance", balance);

        // 🔹 Chuyển hướng đến trang chính
        response.sendRedirect("Home");
    }

    private String sendPostRequest(String urlStr, String params) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setRequestProperty("Accept", "application/json");

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = params.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8).useDelimiter("\\A");
        return scanner.hasNext() ? scanner.next() : "";
    }

    private String sendGetRequest(String urlStr) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8).useDelimiter("\\A");
        return scanner.hasNext() ? scanner.next() : "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String param_user = request.getParameter("username");
        String param_pass = request.getParameter("password");
        String remember = request.getParameter("rem");
        String googleEmail = request.getParameter("google_email"); // Email từ Google login
        CustomerDAO cdao = new CustomerDAO();
        HttpSession session = request.getSession();

        Customer customer = null;

        // 🔹 Nếu đăng nhập bằng Google
        if (googleEmail != null) {
            customer = cdao.getCustomerByEmail(googleEmail);

        } else {
            // 🔹 Nếu đăng nhập thường (username & password)
            if (param_user == null || param_pass == null) {
                request.setAttribute("err", "Invalid login credentials.");
                request.getRequestDispatcher("login/login.jsp").forward(request, response);
                return;
            }

            String pass = cdao.toSHA1(param_pass);

            // Kiểm tra nếu tài khoản bị khóa
            if (lockedAccounts.containsKey(param_user)) {
                Instant lockTime = lockedAccounts.get(param_user);
                Instant now = Instant.now();
                if (now.isBefore(lockTime.plusSeconds(LOCK_TIME_SECONDS))) {
                    request.setAttribute("err", "Your account is locked. Please try again later.");
                    request.getRequestDispatcher("login/login.jsp").forward(request, response);
                    return;
                } else {
                    lockedAccounts.remove(param_user); // Hết thời gian khóa thì mở lại
                }
            }

            // Kiểm tra thông tin đăng nhập
            customer = cdao.checkUser(param_user, pass);
            if (customer == null) {
                // Tăng số lần nhập sai
                Integer attempts = (Integer) session.getAttribute("loginAttempts");
                attempts = (attempts == null) ? 1 : attempts + 1;
                session.setAttribute("loginAttempts", attempts);

                if (attempts >= MAX_ATTEMPTS) {
                    lockedAccounts.put(param_user, Instant.now());
                    request.setAttribute("err", "Too many failed attempts. Your account is locked for 1 minute.");
                } else {
                    request.setAttribute("err", "Invalid username or password. Attempts left: " + (MAX_ATTEMPTS - attempts));
                }
                request.getRequestDispatcher("login/login.jsp").forward(request, response);
                return;
            }

            // Nếu đăng nhập thành công, reset số lần nhập sai
            session.removeAttribute("loginAttempts");
        }

        // Kiểm tra nếu tài khoản bị khóa
        if (customer.getActive() == 0) {
            request.setAttribute("err", "Your account has been blocked!");
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin vào session
        double balance = cdao.getBalanceByCId(customer);
        session.setAttribute("balance", balance);
        session.setAttribute("customer", customer);
        session.setAttribute("customer_id", customer.getCustomerId());

        // Xử lý cookies nếu chọn "Remember Me"
        if (remember != null) {
            Cookie username = new Cookie("username", param_user);
            Cookie password = new Cookie("password", param_pass);
            Cookie remem = new Cookie("rem", remember);
            int cookieAge = 24 * 60 * 60 * 7; // 7 ngày
            username.setMaxAge(cookieAge);
            password.setMaxAge(cookieAge);
            remem.setMaxAge(cookieAge);
            response.addCookie(username);
            response.addCookie(password);
            response.addCookie(remem);
        }

        response.sendRedirect("Home");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
