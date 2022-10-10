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

$query = ('CALL get_exception_for_resource(:rID,1)');
if (!empty($_SESSION['view'])) {


    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $_SESSION['view']);
    $stmt->execute();
    $result = $stmt->fetchAll();
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

    <!--insert name of resource here-->
    <h1>Exception History of Resource X</h1>


    <br>
    <table class="container text-center overflow-scroll">
        <?php

        $count = 0;

        foreach ($result as $row) {

            if ($count == 0) {
                echo '<tr>
            <th>Rule</th>
            <th>Last Updated By</th>
            <th>Justification</th>
            <th>Review Date</th>
            <th>Last Updated</th>
        </tr>';
            }

            echo '
        <tr>
            <td>
                ', $row[0], '
            </td>
            <td>
            ', $row[1], '
            </td>
            <td>
            ', $row[2], '
            </td>
            <td>
            ', $row[3], '
            </td>
            <td>
            ', $row[4], '
            </td>
            <td>
                <button name="report" value=', $row[0], ' class="btn btn-info">Update</button>  
            </td>
            <td>
                <button name="report" value=', $row[0], ' class="btn btn-info">Suspend</button>  
            </td>
   
        </tr>
        ';
            $count += 1;
        }

        if ($count == 0) {
            echo '<p style="text-align:center">There is no exception history for this resource.</p>';
        }

        ?>
    </table>
    </div>

</body>

</html>