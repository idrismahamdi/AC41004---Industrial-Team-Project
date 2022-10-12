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
}
if (isset($_POST['report'])) {
  $_SESSION['rule'] = $_POST['report'];
  header('Location: report.php');
  die();
}
$query = ('SELECT rule_id, rule_name FROM rule');
$stmt = $mysql->prepare($query);
$stmt->execute();
$result = $stmt->fetchAll();
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
    <br>
    <?php echo '<h1>Welcome to the summary dashboard! <br> You are logged in as: ';

  echo $_SESSION['user_name'];
  echo '</h1>';
  ?>
    <br>
    <br>
    <?php
  $j = 0;
  $i = 0;

  foreach ($result as $row) {
    $query = ('CALL get_non_compliant_resource_for_rules(:rID, :cID)');
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $row[0]);
    $stmt->bindValue(':cID', $_SESSION['cID']);
    $stmt->execute();
    $complies = $stmt->fetchAll();
    $query = ('CALL get_exceptions_for_resource_for_a_rule(:rID, :cID)');
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $row[0]);
    $stmt->bindValue(':cID', $_SESSION['cID']);
    $stmt->execute();
    $exempt = $stmt->fetchAll();

    if (empty($complies[0]) || !empty($exempt)) {
      $i = $i + 1;
    }
    $j = $j + 1;
  }
  $i = ($i / $j) * 100;
  ?>

    <div class="main h.custom">
        <!--COMPLIANCE PROGRESS BAR - %COMPLIANCE-->
        <div class="progress" style="height: 30px;">
            <!--ARIA-VALUENOW == NUMBER/PERCENTAGE COMPLIANT-->
            <!--sTYLE WIDTH == NUMBER/PERCENTAGE COMPLIANT-->
            <!--ARIA-VALUEMAX == TOTAL COMPLIANT RESOURCES/ 100 PERCENT-->
            <div class="progress-bar progress-bar-striped progress-bar-animated role=" progressbar"
                aria-label="Compliance Progress Bar" style="width: <?php echo $i; ?>%; height: 30px;"
                aria-valuenow='<?php echo $i; ?>;' aria-valuemin="0" aria-valuemax="100">
                <?php echo $i; ?>% compliant</div>
        </div>
        <br>

        <table class="table table-borderless" style="margin-left:auto;margin-right:auto;text-align:center;">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Compliance</th>
                    <th scope="col">Rule</th>
                    <th scope="col">Detailed Report</th>
                </tr>
            </thead>

            <?php


      foreach ($result as $row) {

        echo '  <tr>
                <td>';

        $query = ('CALL get_non_compliant_resource_for_rules(:rID, :cID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $row[0]);
        $stmt->bindValue(':cID', $_SESSION['cID']);
        $stmt->execute();
        $complies = $stmt->fetchAll();

        $query = ('CALL get_exceptions_for_resource_for_a_rule(:rID, :cID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $row[0]);
        $stmt->bindValue(':cID', $_SESSION['cID']);
        $stmt->execute();
        $exempt = $stmt->fetchAll();


        if (empty($complies[0]) || !empty($exempt)) {
          echo '<img src="compliant.png" height="40px" alt="brightsolid">';
        } else {
          echo '<img src="non-compliant.png" height="40px" alt="brightsolid">';
        }

        echo '
                </td>
                <td>
                    <strong>', $row[1], '
                    </strong>
                </td>
                <td>  <form action="" method="post">
                <button name="report" value=', $row[0], ' class="btn btn-info">Create</button>
                </form>
                 </td>
                </tr>';
      }
      ?>


        </table>
    </div>

</body>

</html>
