<?php
require "connection.php";
session_start();

if ($_SESSION['user_role'] == 2) {
    echo '<script type="text/javascript">';
    echo 'alert("You do not have permission to create an exception");';
    echo 'window.location.href = "view.php";';
    echo '</script>';
}

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

    if ($_POST['reviewDate'] == "oneMonth") {
        $date = new DateTime('now');
        $date->modify('+1 month');
    } else if ($_POST['reviewDate'] == "threeMonths") {
        $date = new DateTime('now');
        $date->modify('+3 month');
    } else  if ($_POST['reviewDate'] == "sixMonths") {
        $date = new DateTime('now');
        $date->modify('+6 month');
    } else if ($_POST['reviewDate'] == "oneYear") {
        $date = new DateTime('now');
        $date->modify('+12 month');
    } else {
        $date = new DateTime($_POST['custom']);
    }

    $date = $date->format('Y-m-d h:i:s');

    $current = new DateTime('now');
    $current = $current->format('Y-m-d h:i:s');

    $query = ("INSERT INTO exception(exception_id,customer_id,rule_id,resource_id,last_updated_by,exception_value,justification,review_date,last_updated) VALUES (NULL,:cID,:ruleID,:resourceID,:lastupdatedby,:rule_name,:justify,:reviewDate,:lastUpdated);");
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':cID', $_SESSION['cID']);
    $stmt->bindValue(':resourceID', $_SESSION['create']);
    $stmt->bindValue(':ruleID', $_SESSION['rule']);
    $stmt->bindValue(':justify', $_POST['justification']);
    $stmt->bindValue(':reviewDate', $date);
    $stmt->bindValue(':rule_name', $_SESSION['rule_name']);
    $stmt->bindValue(':lastUpdated', $current);
    $stmt->bindValue(':lastupdatedby', $_SESSION['user_id']);
    $stmt->execute();
    echo '<script type="text/javascript">';
    echo 'alert("Exception Added");';
    echo 'window.location.href = "dashboard.php";';
    echo '</script>';
    die();
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
            <li class="breadcrumb-item active" aria-current="page">Exception Form</li>
        </ol>
    </nav>
    <br>
    <h1>CREATE AN EXCEPTION</h1>
    <br>
    <div class="main">
        <div class="card">
            <?php include "Components/ExceptionForm/exception-form.php" ?>
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
