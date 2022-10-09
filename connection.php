<?php
//connecting to database hosted on azure server
$host = "bright-solid.mysql.database.azure.com";
$username = "brightsolid";
$password = "password123!";
$database = "brightsolid";

$mysql = new PDO(
    "mysql:host=" . $host . ";dbname=" . $database,
    $username,
    $password
);

