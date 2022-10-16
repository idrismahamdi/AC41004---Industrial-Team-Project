<?php
require "connection.php";
session_start();

if (isset($_POST['view'])) {
    $_SESSION['view'] = $_POST['view'];
    header('Location: view.php');
    die();
}

if (isset($_POST['create'])) {
    $_SESSION['create'] = $_POST['create'];
    header('Location: create.php');
    die();
}

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
            <li class="breadcrumb-item active" aria-current="page">Detailed Report</li>
        </ol>
    </nav>
    <br>
    <h1>DETAILED REPORT</h1>

    <div class="main">
        <?php

        $query = ('CALL get_rule_details(:rID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $_SESSION['rule']);
        $stmt->execute();
        $result = $stmt->fetch();
        echo '<h2>Created for Rule ', $result[0];
        echo '</h2>';
        echo '<p>', $result[1];
        echo '</p>';
         $_SESSION['rule_name'] = $result[0];
        ?>
        <br>

        <?php
        echo '<h3>NON-COMPLIANT RESOURCES</h3>';

        echo '<div class="card">';
        $query = ('CALL get_non_compliant_resource_for_rules(:rID, :cID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $_SESSION['rule']);
        $stmt->bindValue(':cID', $_SESSION['cID']);
        $stmt->execute();
        $result = $stmt->fetchAll();
        $myArr = array();
        $reviewDate = array();
        $countNonCompliant = 0;

        foreach ($result as $row) {

            $query = ('CALL get_exception_for_resource(:resourceID,:cID, :rID)');
            $stmt = $mysql->prepare($query);
            $stmt->bindValue(':resourceID', $row[1]);
            $stmt->bindValue(':rID', $_SESSION['rule']);
            $stmt->bindValue(':cID', $_SESSION['cID']);
            $stmt->execute();
   
            $test = $stmt->fetch();
            if (empty($test)) {

                if ($countNonCompliant == 0) {
                    echo '
                <table class="table table-borderless style="margin-left:auto;margin-right:auto;text-align:center; width: 100%;">
                <thead class="thead-dark">
                    <tr>
                    <th scope="col">Resource Name</th>
                    <th scope="col">Exception History</th>
                    ';
                    if ($_SESSION['user_role'] == 1) {
                        echo '
                    <th scope="col">Create an Exception</th>
                    
                    </tr>
                </thead>
                <tbody>';
                    }
                }
                echo '<tr>';
                echo '<td>', $row[0], '</td>';
                echo ' <td><form action="" method="post"><button name="view" value=', $row[1], ' class="btn btn-info">View</button></form></td>';

                if ($_SESSION['user_role'] == 1) {

                    echo '<td><form action="" method="post"><button name="create" value=', $row[1], ' class="btn btn-info">Create</button> </form></td>';
                }
                echo '</tr>';
                $countNonCompliant += 1;
            } else {
                $myArr[] = $row[0];
                $reviewDate[] = $test[1];
                $lastUpdated[] = $test[2];
                $resourceID[] =  $test[3];
            }
        }
        echo '</tbody></table>';
        if ($countNonCompliant == 0) {
            echo '<p>There is no resourses which do not comply with this rule</p>';
        }
        echo '</div><br>';
        $i = 0;
        echo '<br><h3>COMPLIANT RESOURCES</h3>';
        echo '<div class="card">';

        $countCompliant = 0;
        $query = ('CALL get_resource_for_rules(:rID, :cID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $_SESSION['rule']);
        $stmt->bindValue(':cID', $_SESSION['cID']);
        $stmt->execute();
        $noncompliant = $stmt->fetchAll();
        foreach ($myArr as $item) {
            if ($countCompliant == 0) {
                echo '
                <table class="table" style="margin-left:auto;margin-right:auto;text-align:center;">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">Resource Name</th>
                    <th scope="col">Exempt</th>
                    <th scope="col">Review Date</th>
                    <th scope="col">Last Updated</th>
                    <th scope="col">Exceptions</th>
                </tr>
                </thead>
                <tbody>';
            }
            echo '<tr>';
            echo '<td>', $myArr[$countCompliant], '</td>';
            echo '<td>Yes</td>';
            echo '<td>', $reviewDate[$countCompliant], '</td>';
            echo '<td>', $lastUpdated[$countCompliant], '</td>';
            echo ' <td> <form action="" method="post"><button name="view" value=', $resourceID[$countCompliant], ' class="btn btn-info">View</button></td> </form>';
            echo '</tr>';
            $countCompliant += 1;
        }

        foreach ($noncompliant as $non) {
            foreach ($result as $row) {
                if ($row[0] == $non[0]) {
                    $i += 1;
                }
            }
            if ($i == 0) {
                if ($countCompliant == 0) {
                    echo '
        <table class="table" style="margin-left:auto;margin-right:auto;text-align:center;>
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Resource Name</th>
                    <th scope="col">Exempt</th>
                    <th scope="col">Review Date</th>
                    <th scope="col">Last Updated</th>
                    <th scope="col">Exceptions</th>
                </tr>
            </thead>
            <tbody>';
                }
                echo '<tr>';
                echo '<td>', $non[0], '</td>';
                echo '<td>N/A</td>';
                echo '<td>N/A</td>';
                echo '<td>N/A</td>';
                echo ' <td> <form action="" method="post"> <button name="view" value=', $non[1], ' class="btn btn-info">View</button></td> </form>';
                echo '</tr>';
                $countCompliant += 1;
            }
        }
        echo '</tbody></table>';
        if ($countCompliant == 0) {

            echo '<p style="text-align:center">There is no resourses which do comply with this rule</p>';
        }

        ?>
    </div>
    </div>
    <br>
    <footer>
        Visit our website:<br>
        <a class="footer-link" href="https://www.brightsolid.com/">BrightSolid</a>
    </footer>
</body>

</html>
