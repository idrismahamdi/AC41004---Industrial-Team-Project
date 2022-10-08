<html lang='en'>

<head>

  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT' crossorigin='anonymous'>
  <link rel='stylesheet' href='../../Pages/styling/master.css'>

  <title>This is the title of the webpage!</title>
</head>

<body>
  <header>
    <nav class='navbar navbar-expand-lg fixed-top navbar-dark navbar-expand border'>
      <div class='container'>
        <a class='navbar-brand' href='#'>
          <img src='../../Pages/Images/logo.png' height='100px' alt='brightsolid'>
        </a>
      </div>
      <div class='collapse navbar-collapse' id='navbarNav'>
        <form class='d-flex'>
          <button class='btn b' type='submit'>Home</button>
          <button class='btn p' type='submit'>Log out</button>
        </form>
      </div>
    </nav>
  </header>
  <main class='container'>

  </main>

  <script async src='https://cdn.jsdelivr.net/npm/es-module-shims@1/dist/es-module-shims.min.js' crossorigin='anonymous'></script>
  <script type='importmap'>
    {
      "imports": {
      "@popperjs/core": "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js",
        "bootstrap": "https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.esm.min.js"
      }
    }
  </script>
  <div>
    <h1>Detailed Compliance Report for Rule X</h1>
  </div>

  <br>
  <br>
  <div class = "container">
      <strong>Resource 1: Resource is X </strong>
  <form class="exception-form">
    <fieldset class='row mb-3 align-items-center'>
      <legend class='col-2 col-form-label'>Review in:</legend>
      <div class="col col-auto">
        <div class='btn-group' role='group' aria-label='Review date radio toggle button group'>
          <input type='radio' class='btn-check' name='reviewDate' id='oneMonth' value='oneMonth' autocomplete='off' required>
          <label class='btn btn-outline-primary m-0' for='oneMonth'>1 Month</label>

          <input type='radio' class='btn-check' name='reviewDate' id='threeMonths' value='threeMonths' autocomplete='off' required>
          <label class='btn btn-outline-primary m-0' for='threeMonths'>3 Months</label>

          <input type='radio' class='btn-check' name='reviewDate' id='sixMonths' value='sixMonths' autocomplete='off' required>
          <label class='btn btn-outline-primary m-0' for='sixMonths'>6 Months</label>

          <input type='radio' class="btn-check" name='reviewDate' id='oneYear' value='oneYear' autocomplete='off' required>
          <label class='btn btn-outline-primary m-0' for='oneYear'>1 Year</label>

          <input class="btn-check custom-date-check" name='reviewDate' id="custom" value='custom' type='radio' autocomplete='off' required>
          <label class='btn btn-outline-primary m-0' for='custom'>Custom</label>
        </div>
      </div>

      <div class="col-auto">
        <div class='collapse collapse-horizontal custom-date-collapse' id="customDateCollapse">
          <input type='date' placeholder="Choose a date" class='form-control custom-date-input' id='customDateInput' name='customDate' required>
        </div>
      </div>
    </fieldset>

    <div class='row mb-3 justify-content-start'>
      <div class='col-2'>
        <label for='justification' class='form-label'>Justification:</label>
      </div>
      <div class='col'>
        <textarea class='form-control' id='justification' rows='4' required></textarea>
      </div>
    </div>

    <div class="row mb-3 justify-content-start">
      <div class="col offset-2">
        <button class="btn btn-primary col" type="submit">Create exception</button>
      </div>
    </div>
  </form>
</div>
</div>
</body>
</html>
