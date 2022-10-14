<?php
require "connection.php";

if (isset($_POST['submit'])) {
    //execute sql query to see if the admin is on the database
    try {
        $password = $_POST['password'];
        $password .= 'brightsolid';
        $hashed_password = hash('sha256', $password);
        $query = ('SELECT login((:uName),(:uPassword))');
        $stmt = $mysql->prepare($query);
        $stmt->bindParam(":uName", $_POST['username']);
        $stmt->bindParam(":uPassword", $hashed_password);
        $stmt->execute();
        $result = $stmt->fetch();
        //check to see if exists or not

        if ($result[0] != 0) {
            session_start();
            $_SESSION['loggedin'] = true;
            $query = ('SELECT * FROM user WHERE user_name = :uName');
            $stmt = $mysql->prepare($query);
            $stmt->bindParam(":uName", $_POST['username']);
            $stmt->execute();
            $result = $stmt->fetch();
            $_SESSION['user_name'] = $result[1];
            $_SESSION['user_role'] = $result[3];

            $_SESSION['user_id'] = $result[0];



            $query = ('SELECT customer.customer_id FROM customer 
            LEFT JOIN user ON customer.customer_id = user.customer_id
            WHERE user.user_id = (:uID);');
            $stmt = $mysql->prepare($query);
            $stmt->bindParam(":uID", $_SESSION['user_id']);
            $stmt->execute();
            $result = $stmt->fetch();
            $_SESSION['cID'] = $result[0];
            header('Location: dashboard.php');
            die();
        } else {
            echo '<script type="text/javascript">';
            echo ' alert("Login failed, please check your login details")';
            echo '</script>';
        }
    } catch (exception $e) {
        echo '<script type="text/javascript">';
        echo ' alert("Login failed, please contact website administrator")';
        echo '</script>';
    }
}



?>
<!doctype html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <link rel="stylesheet" href="login_style.css">
    <title>BrightSolid Compliance</title>
</head>

<body>

    <header>
        <img src="logo.png" height="150px" alt="brightsolid" class="w-custom h-custom">
    </header>

    <h1>Cloud Compliance Dashboard Login</h1>
    <div class="main">
        <form class="login h-custom" action="" method="post">
            <input type="text" name="username" class="form-control" id="exampleFormControlInput1" placeholder="Username"
                class="form-control">
            <br>
            <input type="password" name="password" class="form-control" id="password-entry"
                class="login-entry text-input h-custom" placeholder="Password">
            <br>
            <input id="submit" name="submit" type="submit" value="Login" class="login-entry btn b">
        </form>
    </div>
</body>

</html>
