package com.example.test6;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String noteId = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE notes SET title = ?, content = ? WHERE id = ? AND user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setInt(3, Integer.parseInt(noteId));
            stmt.setInt(4, userId);
            stmt.executeUpdate();
            response.sendRedirect("notizen.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Fehler beim Bearbeiten der Notiz.");
        }
    }
}