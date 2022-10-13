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
    echo $date;
    $current = new DateTime('now');
    $current = $current->format('Y-m-d h:i:s');

    $query = ("INSERT INTO exception(exception_id,customer_id,rule_id,resource_id,last_updated_by,exception_value,justification,review_date,last_updated) VALUES (NULL,:cID,:ruleID,:resourceID,:lastupdatedby,'bsol-dev-bakery-assets',:justify,:reviewDate,:lastUpdated);");
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':cID', $_SESSION['cID']);
    $stmt->bindValue(':resourceID', $_SESSION['create']);
    $stmt->bindValue(':ruleID', $_SESSION['rule']);
    $stmt->bindValue(':justify', $_POST['justifcation']);
    $stmt->bindValue(':reviewDate', $date);
    $stmt->bindValue(':lastUpdated', $current);
    $stmt->bindValue(':lastupdatedby', $_SESSION['user_id']);
    $stmt->execute();
    echo '<script type="text/javascript">';
    echo 'alert("Exception Added");';
    echo 'window.location.href = "dashboard.php";';
    echo '</script>';
}


?>
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
            <form class="exception-form" form action="" method="post">
                <fieldset class='row mb-3 align-items-center'>
                    <legend class='col-2 col-form-label'><strong><u>Review in:</u></strong></legend>
                    <div class="col col-auto">
                        <div class='btn-group' role='group' aria-label='Review date radio toggle button group'>
                            <input type='radio' class='btn-check' name='reviewDate' id='oneMonth' value='oneMonth'
                                autocomplete='off'>
                            <label class='btn btn-outline-primary m-0' for='oneMonth'>1 Month</label>
                            <input type='radio' class='btn-check' name='reviewDate' id='threeMonths' value='threeMonths'
                                autocomplete='off'>
                            <label class='btn btn-outline-primary m-0' for='threeMonths'>3 Months</label>

                            <input type='radio' class='btn-check' name='reviewDate' id='sixMonths' value='sixMonths'
                                autocomplete='off'>
                            <label class='btn btn-outline-primary m-0' for='sixMonths'>6 Months</label>

                            <input type='radio' class="btn-check" name='reviewDate' id='oneYear' value='oneYear'
                                autocomplete='off'>
                            <label class='btn btn-outline-primary m-0' for='oneYear'>1 Year</label>


                        </div>
                    </div>

                </fieldset>

                <div class='row mb-3 justify-content-start'>
                    <div class='col-2'>
                        <label for='justification' class='form-label'><strong><u>Justification:</strong></u></label>
                    </div>
                    <div class='col'>
                        <textarea class='form-control' name='justifcation' id='justification' rows='4'
                            required></textarea>
                    </div>
                </div>

                <div class=" row mb-3 justify-content-start">
                    <div class="col offset-2">
                        <button class="btn btn-primary col" name="submit" type="submit">Create
                            exception</button>
                    </div>
                </div>
            </form>
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
