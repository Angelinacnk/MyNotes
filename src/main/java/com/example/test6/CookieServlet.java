package com.example.test6;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cookies")
public class CookieServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hier könntest du Logik einfügen, um Cookies zu lesen oder zu löschen, falls nötig
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("accept".equals(action)) {
            Cookie cookie = new Cookie("cookiesAccepted", "true");
            cookie.setMaxAge(60 * 60 * 24 * 30); // 30 Tage
            cookie.setPath("/");
            response.addCookie(cookie);
        } else if ("decline".equals(action)) {
            Cookie cookie = new Cookie("cookiesAccepted", "false");
            cookie.setMaxAge(0); // Cookie löschen
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        response.sendRedirect(request.getHeader("Referer")); // Zurück zur vorherigen Seite
    }
}
