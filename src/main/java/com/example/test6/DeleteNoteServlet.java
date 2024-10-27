package com.example.test6;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deleteNote")
public class DeleteNoteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String noteId = request.getParameter("id");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "DELETE FROM notes WHERE id = ? AND user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(noteId));
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            response.sendRedirect("notizen.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Fehler beim Löschen der Notiz.");
        }
    }
}
