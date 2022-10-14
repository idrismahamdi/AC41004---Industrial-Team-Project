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
$date = new DateTime('now');
$date = $date->format('Y-m-d h:i:s');

$query = ('SELECT exception_id, review_date FROM exception');
$stmt = $mysql->prepare($query);
$stmt->execute();
$result = $stmt->fetchAll();

foreach ($result as $row) {
    if ($date > $row[1]) {
        $query = ('CALL expired_exception(:rID)');
        $stmt = $mysql->prepare($query);
        $stmt->bindValue(':rID', $row[0]);
        $stmt->execute();
    }
}
