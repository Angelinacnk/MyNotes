<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrieren</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
  <script>
    function acceptCookies() {
      document.cookie = "cookiesAccepted=true; path=/; max-age=" + 60*60*24*30; // 30 Tage
      document.getElementById("cookie-consent").style.display = "none";
    }

    function declineCookies() {
      document.getElementById("cookie-consent").style.display = "none";
      document.cookie = "cookiesAccepted=false; path=/; max-age=" + 60*60*24*30; // 30 Tage
    }

    window.onload = function() {
      if (document.cookie.indexOf("cookiesAccepted=true") === -1) {
        document.getElementById("cookie-consent").style.display = "block";
      }
    }
  </script>
  <style>
    body {
      background-color: #ffcccb; /* Rosafarbener Hintergrund */
      font-family: Arial, sans-serif;
      text-align: center; /* Zentriert alle Texte im Body */
      margin: 0; /* Kein Margin für den Body */
    }
    .container {
      max-width: 400px;
      margin: 0 auto; /* Kein Margin oben oder unten */
      padding: 20px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      position: absolute; /* Positionierung anpassen */
      top: 18%;
      left: 50%; /* Horizontal zentrieren */
      transform: translate(-50%, -50%); /* Zentrieren */
    }
    .input-group {
      display: flex;
      flex-direction: column; /* Elemente untereinander anordnen */
      margin-bottom: 15px; /* Abstand zwischen den Eingabefeldern */
      align-items: stretch; /* Eingabefelder füllen den Container */
    }
    label {
      margin-bottom: 5px; /* Abstand zwischen Label und Eingabefeld */
    }
    input {
      width: 100%; /* Eingabefelder auf volle Breite */
      padding: 10px; /* Innenabstand für die Eingabefelder */
      border: 1px solid #ccc; /* Rahmen um die Eingabefelder */
      border-radius: 4px; /* Abgerundete Ecken */
    }
    button {
      background-color: black; /* Schwarzer Button */
      color: white; /* Weiße Schrift */
      padding: 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%; /* Button auf volle Breite */
    }
    button:hover {
      opacity: 0.8;
    }
    #cookie-consent {
      background-color: #f9f9f9;
      padding: 10px;
      text-align: center;
      border-top: 1px solid #ccc;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Registrieren</h2>
  <form action="register" method="post">
    <div class="input-group">
      <label for="username">Benutzername:</label>
      <input type="text" id="username" name="username" required>
    </div>
    <div class="input-group">
      <label for="password">Passwort:</label>
      <input type="password" id="password" name="password" required>
    </div>
    <button type="submit">Registrieren</button>
  </form>
  <p>Bereits ein Konto? <a href="login.jsp">Anmelden</a></p>
</div>

<div id="cookie-consent" style="display:none; position:fixed; bottom:0; left:0; right:0;">
  <p>Wir verwenden Cookies, um Ihre Erfahrung auf unserer Website zu verbessern.</p>
  <button onclick="acceptCookies()">Zustimmen</button>
  <button onclick="declineCookies()">Ablehnen</button>
</div>
</body>
</html>
