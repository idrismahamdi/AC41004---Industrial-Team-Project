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

if (isset($_POST['suspend'])) {
    $query = ('CALL suspend_exception(:rID,1)');

    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $_POST['suspend']);
    $stmt->execute();
}

if (isset($_POST['update'])) {
    $_SESSION['update'] = $_POST['update'];
    header('Location: update.php');
    die();
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
            <li class="breadcrumb-item active" aria-current="page">Exception History</li>
        </ol>
    </nav>

    <br>
    <!--insert name of resource here-->
    <h1>EXCEPTIONS</h1>
    <?php
    $query = ('SELECT resource_name FROM resource WHERE resource_id = :rID');

    $stmt = $mysql->prepare($query);
    $stmt->bindValue(':rID', $_SESSION['view']);

    $stmt->execute();
    $result = $stmt->fetch();

    echo ' <h2>of Resource', $result, '</h2>'; ?>



    <br>
    <div class="main">
        <div class="card">
            <table class="container text-center overflow-scroll">
                <?php

                $query = ('CALL get_exceptions(:rID,:cID)');
                if (!empty($_SESSION['view'])) {


                    $stmt = $mysql->prepare($query);
                    $stmt->bindValue(':rID', $_SESSION['view']);
                    $stmt->bindValue(':cID', $_SESSION['cID']);

                    $stmt->execute();
                    $result = $stmt->fetchAll();
                }

                $count = 0;
                foreach ($result as $row) {

                    if ($count == 0) {

                        echo '    <h1>CURRENT EXCEPTIONS</h1>
                        <tr>
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
            <td>';
                    if ($_SESSION['user_role'] == 1) {

                        echo ' <form action="" method="post">
                <button name="update" value=', $row[5], ' class="btn btn-info">Update</button> 
                <form action="" method="post">
            </td>
            <td>
            <form action="" method="post">
                <button name="suspend" value=', $row[5], ' class="btn btn-info">Suspend</button>  
                <form action="" method="post">
            </td>
   
        </tr> ';
                    }
                    $count += 1;
                }

                if ($count == 0) {
                    echo '<p style="text-align:center">There is no current exceptions for this resource.</p>';
                }

                ?>
            </table>



        </div>
    </div>


    <div class="main">
        <div class="card">
            <table class="container text-center overflow-scroll">
                <?php

                $query = ('CALL get_Exception_History_For_Resource(:cID,:rID)');
                if (!empty($_SESSION['view'])) {
                    $stmt = $mysql->prepare($query);
                    $stmt->bindValue(':rID', $_SESSION['view']);
                    $stmt->bindValue(':cID', $_SESSION['cID']);
                    $stmt->execute();
                    $result = $stmt->fetchAll();
                }

                $count = 0;
                foreach ($result as $row) {

                    if ($count == 0) {
                        if (($row[3] == NULL) || ($row[6] == NULL)) {
                            $row[3] = 'N/A';
                            $row[5] = 'N/A';
                        }
                        echo '    <h1>HISTORIC EXCEPTIONS</h1>
                        <tr>
                    
            <th>Action</th>
            <th>Date of Action</th>
            <th>Exception Value</th>
            <th>New Justifcation</th>
            <th>Old Justifcation</th>
            <th>New Review Date</th>
            <th>Old Review Date</th>
            
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
            ', $row[5], '
            </td>
            <td>
            ', $row[6], '
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
    </div>
    </div>
    <br>
    <footer>
        <p>Visit our website:<br>
            <a class="footer-link" href="https://www.brightsolid.com/">BrightSolid</a>
        </p>
    </footer>
</body>

</html>
