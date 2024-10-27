<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.test6.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gespeicherte Notizen</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #ffcccb; /* Hintergrund rosa */
      color: #333;
      margin: 0;
      padding: 20px;
    }
    h2 {
      color: #5a5a5a;
      text-align: center; /* Titel zentrieren */
    }
    .container {
      display: flex;
      justify-content: space-between;
      max-width: 1200px;
      margin: auto;
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }
    .logout {
      position: absolute;
      top: 20px;
      right: 20px;
      font-size: 16px;
    }
    .logout a {
      color: #333;
      text-decoration: none;
      padding: 8px 12px;
      background-color: #e0e0e0;
      border-radius: 4px;
    }
    .logout a:hover {
      background-color: #ccc;
    }
    .notizen-container, .eingabe-container {
      flex: 1;
      padding: 20px;
    }
    .notizen-container {
      border-right: 1px solid #e0e0e0;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px; /* Abstand unter dem Tisch */
    }
    th, td {
      border: 1px solid #e0e0e0;
      padding: 12px;
      text-align: left;
    }
    th {
      background-color: #f0f0f0;
    }
    tr:hover {
      background-color: #f9f9f9;
    }
    a {
      text-decoration: none; /* Entfernt den Unterstrich */
      color: #333; /* Setzt die Farbe der Icons */
      margin: 0 10px; /* Abstand zwischen den Icons */
    }
    input[type="text"], textarea {
      width: 100%; /* Eingabefelder und Textarea nehmen die gesamte Breite ein */
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      margin-bottom: 10px; /* Abstand zwischen den Eingabefeldern */
    }
    input[type="submit"] {
      background-color: #5a5a5a; /* Button-Hintergrund */
      color: white; /* Button-Textfarbe */
      border: none;
      padding: 10px;
      border-radius: 4px;
      cursor: pointer;
      width: 100%; /* Button nimmt die gesamte Breite ein */
    }
    input[type="submit"]:hover {
      background-color: #333; /* Button-Hover-Farbe */
    }
  </style>
</head>
<body>
<div class="container">
  <div class="logout">
    <a href="LogoutServlet">Abmelden</a>
  </div>
  <%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
      response.sendRedirect("login.jsp");
      return;
    }
  %>
  <div class="notizen-container">
    <h2>Gespeicherte Notizen</h2>
    <table>
      <tr>
        <th>Titel</th>
        <th>Inhalt</th>
        <th>Aktionen</th>
      </tr>
      <%
        try (Connection conn = DatabaseConnection.getConnection()) {
          String sql = "SELECT * FROM notes WHERE user_id=?";
          PreparedStatement stmt = conn.prepareStatement(sql);
          stmt.setInt(1, userId);
          ResultSet rs = stmt.executeQuery();

          while (rs.next()) {
      %>
      <tr>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("content") %></td>
        <td>
          <a href="editNote.jsp?id=<%= rs.getInt("id") %>" title="Bearbeiten">
            <i class="fas fa-pencil-alt"></i> <!-- Stift-Icon -->
          </a>
          <a href="DeleteNoteServlet?id=<%= rs.getInt("id") %>" title="Löschen" onclick="return confirm('Möchten Sie diese Notiz wirklich löschen?');">
            <i class="fas fa-trash-alt"></i> <!-- Papierkorb-Icon -->
          </a>
        </td>
      </tr>
      <%
          }
        } catch (Exception e) {
          e.printStackTrace();
        }
      %>
    </table>
  </div>
  <div class="eingabe-container">
    <h2>Neue Notiz hinzufügen</h2>
    <form action="addNote" method="post">
      <label for="title">Titel:</label>
      <input type="text" name="title" id="title" required>
      <label for="content">Inhalt:</label>
      <textarea name="content" id="content" required></textarea>
      <input type="submit" value="Hinzufügen">
    </form>
  </div>
</div>
</body>
</html>
