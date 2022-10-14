<?php
require "connection.php";
session_start();

if ($_SESSION['user_role'] == 2) {
    echo '<script type="text/javascript">';
    echo 'alert("You do not have permission to update an exception");';
    echo 'window.location.href = "view.php";';
    echo '</script>';}

if ($_SESSION['loggedin'] == false) {
    header('Location: login.php');
    die();
}

if (isset($_POST['logout'])) {
    session_destroy();
    header('Location: login.php');
    die();
}

if (isset($_POST['submit'])) {
    $date = new DateTime('now');
    if ($_POST['reviewDate'] == "oneMonth") {
        $date->modify('+1 month'); // or you can use '-90 day' for deduct
    } else if ($_POST['reviewDate'] == "threeMonth") {

        $date->modify('+3 month');
    } else  if ($_POST['reviewDate'] == "sixMonth") {
        $date->modify('+6 month');
    } else if ($_POST['reviewDate'] == "oneYear") {
        $date->modify('+12 month');
    }
    $date = $date->format('Y-m-d h:i:s');
    $current = new DateTime('now');
    $current = $current->format('Y-m-d h:i:s');

    $query = ("CALL update_exception(:eID,:uID,:reviewDate,:justify);");
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':eID', $_SESSION['update']);
    $stmt->bindValue(':uID', $_SESSION['user_id']);
    $stmt->bindValue(':justify', $_POST['justification']);
    $stmt->bindValue(':reviewDate', $date);
    $stmt->execute();

    echo '<script type="text/javascript">';
    echo 'alert("Exception Updated");';
    echo 'window.location.href = "view.php";';
    echo '</script>';
}


?>
<!doctype html>
<html lang="en">

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
        <nav class="navbar border">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="logo.png" height="50px" alt="brightsolid">
                </a>
                <form action="" method="post">
                    <button name="logout" class="btn p" type="submit">Log Out</button>
                </form>
            </div>
        </nav>
    </header>
    <br>
    <nav aria-label="breadcrumb" class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="dashboard.php">Summary Dashboard</a></li>
            <li class="breadcrumb-item"><a href="report.php">Detailed Report</a></li>
            <li class="breadcrumb-item"><a href="view.php">Exception History</a></li>
            <li class="breadcrumb-item active" aria-current="page">Exception Form</li>
        </ol>
    </nav>
    <br>
    <h1>UPDATE AN EXCEPTION</h1>
    <br>
    <div class="main">
        <div class="card">
            <?php include "Components/ExceptionForm/exception-form.html"; ?>
        </div>
    </div>
    <script async src='https://cdn.jsdelivr.net/npm/es-module-shims@1/dist/es-module-shims.min.js'
        crossorigin='anonymous'></script>
    <script type='importmap'>
        {
    "imports": {
    "@popperjs/core": "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js",
      "bootstrap": "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.esm.min.js"
    }
  }
</script>
    <script type="module" src="Components/ExceptionForm/exception-form.js"></script>
    <br>
    <footer>
        Visit our website:<br>
            <a class="footer-link" href="https://www.brightsolid.com/">BrightSolid</a>
    </footer>
</body>

</html>
