<?php

/**
 * @param $reviewDate "date as unix timestamp"
 * @return void
 */
function getExceptionForm(string $reviewDate = "", string $justification = "") {
    echo "
      <form>
        <div class='row mb-3'>
          <label for='reviewDate' class='col-2 col-form-label'>Review in:</label>
          <div class='col'>
            <div class='btn-group' role='group' aria-label='Review date radio toggle button group'>
              <input type='radio' class='btn-check' name='reviewDate' id='oneMonth' autocomplete='off' checked>
              <label class='btn btn-outline-primary m-0' for='oneMonth'>1 Month</label>
            
              <input type='radio' class='btn-check' name='reviewDate' id='threeMonths' autocomplete='off'>
              <label class='btn btn-outline-primary m-0' for='threeMonths'>3 Months</label>
            
              <input type='radio' class='btn-check' name='reviewDate' id='sixMonths' autocomplete='off'>
              <label class='btn btn-outline-primary m-0' for='sixMonths'>6 Months</label>
              
              <input type='radio' class='btn-check' name='reviewDate' id='oneYear' autocomplete='off'>
              <label class='btn btn-outline-primary m-0' for='oneYear'>1 Year</label>
              
              <button class='btn-check' name='reviewDate' id='custom'>
                <input type='radio' autocomplete='off' data-bs-toggle='collapse' data-bs-target='#customDateContainer' aria-expanded='false' aria-controls='customDateInput'>
              </button>
              <label class='btn btn-outline-primary m-0' for='custom'>Custom</label>
            </div>
            <div class='col collapse' id='customDateContainer'>
              <input type='date' class='form-control' id='customDateSelector' name='customDate'>
            </div>
          </div>
        </div>
        <div class='row mb-3'>
          <div class='col-2'>
            <label for='justification' class='form-label'>Justification:</label>          
          </div>
          <div class='col'>
            <textarea class='form-control' id='justification' rows='3'>$justification</textarea>
          </div>
        </div>      
      </form>
    ";
}
