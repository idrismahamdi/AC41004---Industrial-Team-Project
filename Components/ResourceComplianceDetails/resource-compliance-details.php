<?php
$resourceID = $resourceDetails["resourceID"];
$resourceName = $resourceDetails["resourceName"];
$isCompliant = $resourceDetails["isCompliant"];
$exceptionCreator = $resourceDetails["exceptionCreator"];
$exceptionJustification = $resourceDetails["exceptionJustification"];
$exceptionReviewDate = $resourceDetails["exceptionReviewDate"];
$hasHistory = $resourceDetails["hasHistory"];

$exceptionBadge = strlen($exceptionCreator) > 0
    ? "<span class='badge bg-danger'>Exception</span>"
    : "";
$resourceHeader = "<h4 class='col col-auto ".($isCompliant ? "text-success" : "text-danger")."'>$resourceName ".$exceptionBadge."</h4>";
$reviewDate = strlen($exceptionCreator) > 0
    ? "<p class='col col-auto'>Review is due on: $exceptionReviewDate</p>"
    : "";

$exceptionFormButtonLabel = (strlen($exceptionCreator) > 0 ? "Update" : "Create")." exception";
$exceptionFormButtonVisibility = $isCompliant && strlen($exceptionCreator) == 0 ? "invisible" : "visible";
$exceptionHistoryButtonVisibility = $hasHistory ? "visible" : "invisible";

$exceptionDetails = strlen($exceptionCreator) == 0
    ? ""
    : "<div class='row'>
        <p>An exception has been set by <strong>$exceptionCreator</strong> for the following reason:</p>
        <p>$exceptionJustification</p>
      </div>";
?>

<div class="row border-bottom mt-3">
  <div class="row">
    <div class="col me-auto">
      <div class="row align-items-baseline">
        <?=$resourceHeader ?>
        <?=$reviewDate ?>
      </div>
    </div>
    <form class="col col-auto" method="post">
      <?php echo "<button type='button' class='btn btn-primary $exceptionFormButtonVisibility' name='create' value='$resourceID'>$exceptionFormButtonLabel</button>";?>
    </form>
    <form class="col col-auto" method="post">
      <?php echo "<button type='button' class='btn btn-info $exceptionHistoryButtonVisibility' name='view' value='$resourceID'>View exception history</button>" ?>
    </form>
  </div>
  <?=$exceptionDetails ?>
</div>
