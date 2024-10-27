<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Notiz bearbeiten</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f0f8ff; /* Heller Hintergrund */
      color: #000000;
      margin: 0;
      padding: 20px;
      display: flex;
      flex-direction: column;
      align-items: center; /* Zentrieren der Elemente */
    }
    h2 {
      color: #2c3e50; /* Dunklere Überschrift */
      margin-bottom: 20px; /* Abstand unter der Überschrift */
    }
    form {
      background-color: #ffffff; /* Weißer Hintergrund für das Formular */
      border-radius: 8px; /* Abgerundete Ecken */
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Schatten */
      padding: 200px;
      width: 100%;
      max-width: 600px; /* Maximale Breite des Formulars */
    }
    input[type="text"], textarea {
      border: 1px solid #ccc; /* Graue Rahmen */
      border-radius: 4px;
      padding: 10px;
      margin-bottom: 10px;
      font-size: 16px;
      transition: border-color 0.3s; /* Übergang für die Rahmenfarbe */
    }
    input[type="text"]:focus, textarea:focus {
      border-color: #5cb85c; /* Rahmenfarbe bei Fokus */
      outline: none; /* Entfernen des Standardfokus */
    }
    input[type="submit"] {
      background-color: #AAABA8;
      color: white;
      border: none;
      border-radius: 4px;
      padding: 10px;
      cursor: pointer;
      font-size: 16px;
      transition: background-color 0.3s;
    }
    input[type="submit"]:hover {
      background-color: #AAABA8;
    }
    .markieren-button {
      background-color: yellow; /* Gelber Hintergrund für den Button */
      border: none;
      border-radius: 4px; /* Abgerundete Ecken */
      padding: 10px;
      cursor: pointer;
      font-size: 16px;
      margin-top: 10px; /* Abstand nach oben */
      transition: background-color 0.3s; /* Übergang für Hover-Effekte */
    }
    .markieren-button:hover {
      background-color: #ffd700; /* Dunkleres Gelb bei Hover */
    }
    .content-editable {
      border: 1px solid #ccc;
      border-radius: 4px;
      padding: 10px;
      min-height: 150px; /* Mindesthöhe für das editierbare Feld */
      margin-bottom: 10px;
      font-size: 16px;
      transition: border-color 0.3s;
    }
    .content-editable:focus {
      border-color: #5cb85c; /* Rahmenfarbe bei Fokus */
      outline: none; /* Entfernen des Standardfokus */
    }
  </style>
</head>
<body>
<h2>Notiz bearbeiten</h2>
<%
  String jdbcUrl = "jdbc:mysql://localhost:3306/notes_db";
  String username = "angelinachernikov@gmail.com"; // Benutzername
  String password = "Projekt123!"; // Passwort
  String noteId = request.getParameter("id");
  String title = "";
  String content = "";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(jdbcUrl, username, password);

    // Notiz abrufen
    String sql = "SELECT * FROM notes WHERE id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, noteId);
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
      title = rs.getString("title");
      content = rs.getString("content");
    }
    conn.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>
<form action="updateNote" method="post">
  <input type="hidden" name="id" value="<%= noteId %>">
  Titel: <input type="text" name="title" value="<%= title %>" required>
  <!-- Inhalt in einem div anzeigen, um HTML korrekt darzustellen -->
  Inhalt:
  <div contenteditable="true" class="content-editable" id="contentEditable" required><%= content %></div>
  <input type="hidden" name="content" id="contentInput" required>
  <input type="submit" value="Aktualisieren">
</form>

<!-- Button zum Markieren -->
<button class="markieren-button" id="highlightButton">Markieren</button>

<script>
  // Textmarker-Funktion
  document.addEventListener('DOMContentLoaded', function() {
    const contentEditable = document.getElementById('contentEditable');
    const contentInput = document.getElementById('contentInput');
    const highlightButton = document.getElementById('highlightButton');

    highlightButton.onclick = function() {
      const selection = window.getSelection();
      if (!selection.rangeCount) return; // Nichts ausgewählt
      const range = selection.getRangeAt(0);
      const selectedText = range.toString();

      if (selectedText.length > 0) {
        const highlightedText = document.createElement('span');
        highlightedText.style.backgroundColor = 'yellow'; // Hintergrundfarbe
        highlightedText.textContent = selectedText;
        range.deleteContents(); // Ausgewählten Text löschen
        range.insertNode(highlightedText); // Neuen hervorgehobenen Text einfügen
      } else {
        alert("Bitte wählen Sie einen Text zum Markieren aus.");
      }
    };

    // Update contentInput before form submission
    document.querySelector('form').onsubmit = function() {
      contentInput.value = contentEditable.innerHTML; // Speichere den HTML-Inhalt
    };
  });
</script>
</body>
</html>
