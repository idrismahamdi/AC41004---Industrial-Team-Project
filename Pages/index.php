<?php
session_start();
require_once(dirname(__DIR__) . "/Components/exception-form.php");
echo "
<html>

<head>

  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT' crossorigin='anonymous'>
  <link rel='stylesheet' href='styling/master.css'>

  <title>This is the title of the webpage!</title>
</head>";
require_once(dirname(__DIR__)."/connection.php");
//$stm = $mysql->prepare("call login(:uName,:uPassword)");
//$stm->bindParam(':uName', $username);
//$stm->bindParam(':uPassword', $password);
//$stm->execute();
//require_once

echo "
<body>
  <header>
    <nav class='navbar navbar-expand-lg fixed-top navbar-dark navbar-expand border' style='background-color: #115E67;'>
      <div class='container'>
        <a class='navbar-brand' href='#'>
          <img src='Images/logo.png' height='100px' alt='brightsolid'>
        </a>
      </div>
      <div class='collapse navbar-collapse' id='navbarNav'>
        <form class='d-flex' role='button'>
       <button class='btn b' type='submit'>home</button>
       <button class='btn p' type='submit'>log out</button>
     </form>
      </div>
    </nav>
  </header>
  <main class='container' style='margin-top: 200px'>";
getExceptionForm();
echo "  </main>
  
  <script async src='https://cdn.jsdelivr.net/npm/es-module-shims@1/dist/es-module-shims.min.js' crossorigin='anonymous'></script>
  <script type='importmap'>
  {
    \"imports\": {
    \"@popperjs/core\": \"https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js\",
      \"bootstrap\": \"https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.esm.min.js\"
    }
  }
  </script>
  <script type='module'>
    import * as bootstrap from 'bootstrap'

    const dateSelection = document.getElementsByName('reviewDate');
//    const customDateInput = document.getElementById('customDateCollapse');
    const customDateInput = new bootstrap.Collapse('#customDateCollapse', {'toggle': false});
    for (let dateSelectionElement of dateSelection) {
        dateSelectionElement.addEventListener('click', (event) => {
            event.target.value === 'custom'
                ? customDateInput.show
                : customDateInput.hide;
        });
    }

    </script>
</body>
</html>";
