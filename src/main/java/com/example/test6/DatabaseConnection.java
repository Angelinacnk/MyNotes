package com.example.test6;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/notes_db"; // Ersetze mit deinem DB-URL
    private static final String USER = "angelinachernikov@gmail.com"; // Ersetze mit deinem DB-Benutzernamen
    private static final String PASSWORD = "Projekt123!"; // Ersetze mit deinem DB-Passwort


    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

