<?php
require "connection.php";
session_start();

if ($_SESSION['loggedin'] == false) {
  header('Location: login.php');
  die();
}
if (isset($_POST['logout'])) {
  session_destroy();
  header('Location: login.php');
  die();
} ?>
<!doctype html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  <link rel="stylesheet" href="master.css">
  <title>Dashboard</title>
</head>

<body>
<header>
  <nav class="navbar">
    <div class="container">
      <a class="navbar-brand" href="#">
        <img src="logo.png" height="100px" alt="brightsolid">
      </a>
      <form action="" method="post">
        <button name="logout" class="btn p" type="submit">Log Out</button>
      </form>
    </div>
  </nav>
</header>
<main class="container">
  <?php include "Components/ExceptionForm/exception-form.html"; ?>
</main>
</body>
</html>