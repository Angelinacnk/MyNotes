package com.example.test6;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addNote")
public class AddNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO notes (user_id, title, content) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, content);
            stmt.executeUpdate();
            response.sendRedirect("notizen.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Fehler beim Hinzufügen der Notiz.");
        }
    }
}