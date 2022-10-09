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
}

$query = ("CALL get_resource_for_rules(:rID, :cID)");
$stmt = $mysql->prepare($query);
$stmt->bindValue(':rID', $_SESSION['rule']);
$stmt->bindValue(':cID', 1);
$stmt->execute();
$results = $stmt->fetchAll();
$nonCompliantResources = array();
$compliantResources = array();

foreach ($results as $resource) {
  $resourceDetails = array();
  $resourceDetails["resourceID"] = $resource["resource_id"];
  $resourceDetails["resourceName"] = $resource["resource_name"];
  $resourceDetails["isCompliant"] = true;
  $resourceDetails["exceptionCreator"] = "";
  $resourceDetails["exceptionJustification"] = "";
  $resourceDetails["exceptionReviewDate"] = "";
  $resourceDetails["hasHistory"] = true;

  $query = ("SELECT COUNT(*) FROM non_compliance WHERE rule_id =".$_SESSION["rule"]." AND resource_id = ".$resource["resource_id"]);
  $stmt = $mysql->prepare($query);
  $stmt->execute();
  $isCompliant = $stmt->fetchColumn();
  $resourceDetails["isCompliant"] = $isCompliant == 0;

  $query = ('CALL get_exceptions_for_resource_for_a_rule(:rID,:cID)');
  $stmt = $mysql->prepare($query);
  $stmt->bindValue(':rID', $_SESSION['rule']);
  $stmt->bindValue(':cID', 1);
  $stmt->execute();
  $exception = $stmt->fetch();

  if (!empty($exception)) {
    $query = ('SELECT * FROM customer WHERE customer_id = 1');
    $stmt = $mysql->prepare($query);
    $stmt->execute();
    $user = $stmt->fetch();
    $resourceDetails["exceptionCreator"] = $user["customer_name"];

    if (strtotime($exception["review_date"]) > strtotime("today")) {
      $resourceDetails["isCompliant"] = true;
    }
    $resourceDetails["exceptionJustification"] = $exception["justification"];
    $resourceDetails["exceptionReviewDate"] = $exception["review_date"];
  }

  $resourceDetails["isCompliant"]
      ? $compliantResources[] = $resourceDetails
      : $nonCompliantResources[] = $resourceDetails;
}
?>
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
<main class="container">

  <h1>Detailed report created for rule <?=$_SESSION['rule'] ?></h1>
  <h2>Non compliant resources</h2>
  <?php
  foreach ($nonCompliantResources as $resourceDetails) {
    include "Components/ResourceComplianceDetails/resource-compliance-details.php";
  }
  if (sizeof($nonCompliantResources) == 0) {
    echo '<p style="text-align:center">There is no resourses which do not comply with this rule</p>';
  }
  ?>

  <h2>Compliant resources</h2>
  <?php
  foreach ($compliantResources as $resourceDetails) {
    include "Components/ResourceComplianceDetails/resource-compliance-details.php";
  }
  if (sizeof($compliantResources) == 0) {
    echo '<p style="text-align:center">There is no resourses which do comply with this rule</p>';
  }
  ?>

</main>

</html>
