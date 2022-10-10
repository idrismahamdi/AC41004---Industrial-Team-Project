<?php
require "connection.php";
session_start();

if (isset($_POST['view'])) {
    header('Location: view.php');
    die();
}

if (isset($_POST['create'])) {
    header('Location: exceptionForm.php');
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
                    <img src="logo.png" height="100px" alt="brightsolid">
                </a>
                <form action="" method="post">
                    <button name="logout" class="btn p" type="submit">Log Out</button>
                </form>
            </div>
        </nav>
    </header>
    <br>
    <?php echo '<h1>Detailed Report Created for Rule ', $_SESSION['rule'];
    echo '</h1>';
    ?>
    <br>
    <br>
    <?php
    echo '<u><h1>Non-Compliant Resources</h1></u>';


    $query = ('CALL get_non_compliant_resource_for_rules(:rID, :cID)');
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $_SESSION['rule']);
    $stmt->bindValue(':cID', 1);
    $stmt->execute();
    $result = $stmt->fetchAll();
    $myArr = array();
    $reviewDate = array();
    $countNonCompliant = 0;

    foreach ($result as $row) {

        $query = ('CALL get_exceptions_for_resource_for_a_rule(:rID,:cID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $_SESSION['rule']);
        $stmt->bindValue(':cID', 1);
        $stmt->execute();
        $test = $stmt->fetch();
        if (empty($test)) {

            if ($countNonCompliant == 0) {
                echo '

            <table class="table table-borderless border" style="margin-left:auto;margin-right:auto;text-align:center;">
                <thead class="thead-dark" style = "color:#f1b434;font-size:20px;font-weight:bold;text-decoration:underline">
                    <tr>
                    <th scope="col">Resource Name</th>
                    <th scope="col">Exceptions</th>
                    <th scope="col">Create an Exception</th>
                    </tr>
                </thead>';
            }
            echo '<tr style = "background-color: #f1b434; color: #115E67">';
            echo '<td>', $row[0], '</td>';
            echo ' <td><form action="" method="post"><button name="view" value=', $row[0], ' class="btn btn-info">View</button></form></td>';
            echo '<td><form action="" method="post"><button name="create" value=', $row[0], ' class="btn btn-info">Create</button> </form></td>';
            echo '</tr>';
            $countNonCompliant += 1;
        } else {
            $myArr[] = $row[0];
            $reviewDate[] = $row[2];
        }
    }
    echo '</table>';
    if ($countNonCompliant == 0) {
        echo '<p style="text-align:center">There is no resourses which do not comply with this rule</p>';
    }

    $i = 0;
    echo '<u><h1>Compliant resources</h1></u>';

    $countCompliant = 0;
    $query = ('CALL get_resource_for_rules(:rID, :cID)');
    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $_SESSION['rule']);
    $stmt->bindValue(':cID', 1);
    $stmt->execute();
    $noncompliant = $stmt->fetchAll();
    foreach ($myArr as $item) {
        if ($countCompliant == 0) {
            echo '
    <table class="table table-borderless border" style="margin-left:auto;margin-right:auto;text-align:center">
        <thead class="thead-dark" style = "color:#f1b434;font-size:20px;font-weight:bold;text-decoration:underline">
            <tr>
                <th scope="col">Resource Name</th>
                <th scope="col">Exempt</th>
                <th scope="col">Review Date</th>
                <th scope="col">Exceptions</th>
            </tr>
        </thead>';
        }
        echo '<tr style = "background-color: #f1b434; color: #115E67">';
        echo '<td>', $myArr[$countCompliant] , '</td>';
        echo '<td>Yes</td>';
        echo '<td>', $reviewDate[$countCompliant] ,'</td>';
        echo ' <td> <form action="" method="post"><button name="view" value=', $myArr[$countCompliant], ' class="btn btn-info">View</button></td> </form>';
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
        <table class="table table-borderless" style="margin-left:auto;margin-right:auto;text-align:center;">
            <thead class="thead-dark" style = "color:#f1b434;font-size:20px;font-weight:bold;text-decoration:underline">
                <tr>
                    <th scope="col">Resource Name</th>
                    <th scope="col">Exempt</th>
                    <th scope="col">Review Date</th>
                    <th scope="col">Exceptions</th>
                </tr>
            </thead>';
            }
            echo '<tr style = "background-color: #f1b434; color: #115E67">';
            echo '<td>', $non[0], '</td>';
            echo '<td>N/A</td>';
            echo '<td>N/A</td>';
            echo ' <td>
            <form action="" method="post"> <button name="view" value=', $non[0], ' class="btn btn-info">View</button></td> </form>';
            echo '</tr>';
            $countCompliant += 1;
        }
    }
    echo '</table>';
    if ($countCompliant == 0) {

        echo '<p style="text-align:center">There is no resourses which do comply with this rule</p>';
    }




    ?>


    </table>
    </div>

</body>

</html>
