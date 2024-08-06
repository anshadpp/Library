package sample.user.dashboard.web;

import java.io.IOException;
import java.util.Random;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.user.dashboard.database.UserProfileDao;
import sample.user.dashboard.model.User;
import sample.user.dashboard.util.SmsUtil;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserProfileDao userProfileDao;

    public void init() {
        userProfileDao = new UserProfileDao(); // Initialize your DAO correctly
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));

        // Fetch user details based on id
        User user = userProfileDao.getUserById(userId);

        if (user != null) {
            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
            dispatcher.forward(request, response);
        } else {
            response.getWriter().println("User not found");
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//        HttpSession session = request.getSession();
//
//        if ("sendOtp".equals(action)) {
//            String phone = request.getParameter("phone");
//            String otp = generateOTP();
//
//            // Store the OTP in session
//            System.out.println("Generated OTP: " + otp);
//            System.out.println("Phone: " + phone);
//            session.setAttribute("otp", otp);
//            session.setAttribute("otpPhone", phone);
//
//            // Send OTP via SMS
//            SmsUtil.sendOtp(phone, otp);
//
//            response.sendRedirect("profile?id=" + request.getParameter("id"));
//        } else if ("verifyOtp".equals(action)) {
//            String otp = request.getParameter("otp");
//            String sessionOtp = (String) session.getAttribute("otp");
//            String sessionPhone = (String) session.getAttribute("otpPhone");
//
//            if (otp != null && otp.equals(sessionOtp)) {
//                // Mark phone as verified in the database
//                int userId = Integer.parseInt(request.getParameter("id"));
//                userProfileDao.updatePhoneVerified(userId, true);
//
//                session.removeAttribute("otp");
//                session.removeAttribute("otpPhone");
//                response.sendRedirect("profile?id=" + userId + "&verified=true");
//            } else {
//                response.sendRedirect("profile?id=" + request.getParameter("id") + "&error=Invalid OTP");
//            }
//        } else {
//            doGet(request, response);
//        }
//    }
//
//    private String generateOTP() {
//        Random random = new Random();
//        int otp = 100000 + random.nextInt(900000);
//        return String.valueOf(otp);
//    }
}
