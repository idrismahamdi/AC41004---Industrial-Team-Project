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
  <form class="exception-form">
  <fieldset class='row mb-3 align-items-center'>
    <legend class='col-2 col-form-label'><strong><u>Review in:</u></strong></legend>
    <div class="col col-auto">
      <div class='btn-group' role='group' aria-label='Review date radio toggle button group'>
        <input type='radio' class='btn-check' name='reviewDate' id='oneMonth' value='oneMonth' autocomplete='off' required>
        <label class='btn btn-outline-primary m-0' for='oneMonth'>1 Month</label>

        <input type='radio' class='btn-check' name='reviewDate' id='threeMonths' value='threeMonths' autocomplete='off' required>
        <label class='btn btn-outline-primary m-0' for='threeMonths'>3 Months</label>

        <input type='radio' class='btn-check' name='reviewDate' id='sixMonths' value='sixMonths' autocomplete='off' required>
        <label class='btn btn-outline-primary m-0' for='sixMonths'>6 Months</label>

        <input type='radio' class="btn-check" name='reviewDate' id='oneYear' value='oneYear' autocomplete='off' required>
        <label class='btn btn-outline-primary m-0' for='oneYear'>1 Year</label>

        <input class="btn-check custom-date-check" name='reviewDate' id="custom" value='custom' type='radio' autocomplete='off' required>
        <label class='btn btn-outline-primary m-0' for='custom'>Custom</label>
      </div>
    </div>

    <div class="col-auto">
      <div class='collapse collapse-horizontal custom-date-collapse' id="customDateCollapse">
        <input type='date' placeholder="Choose a date" class='form-control custom-date-input' id='customDateInput' name='customDate' required>
      </div>
    </div>
  </fieldset>

  <div class='row mb-3 justify-content-start'>
    <div class='col-2'>
      <label for='justification' class='form-label'><strong><u>Justification:</strong></u></label>
    </div>
    <div class='col'>
      <textarea class='form-control' id='justification' rows='4' required></textarea>
    </div>
  </div>

  <div class="row mb-3 justify-content-start">
    <div class="col offset-2">
      <button class="btn btn-primary col" type="submit">Create exception</button>
    </div>
  </div>
</form>
</div>
</div>
<script async src='https://cdn.jsdelivr.net/npm/es-module-shims@1/dist/es-module-shims.min.js' crossorigin='anonymous'></script>
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
