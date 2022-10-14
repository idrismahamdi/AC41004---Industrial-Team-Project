<form class="exception-form" action="" method="post">
    <fieldset class='row mb-3 align-items-center'>
        <legend class='col-2 col-form-label'><strong><u>Review in:</u></strong></legend>
        <div class="col col-auto">
            <div class='btn-group' role='group' aria-label='Review date radio toggle button group'>
                <input type='radio' class='btn-check' name='reviewDate' onclick="hideDate();" id='oneMonth'
                    value='oneMonth' autocomplete='off' required>
                <label class='btn btn-outline-primary m-0' for='oneMonth'>1 Month</label>

                <input type='radio' class='btn-check' name='reviewDate' onclick="hideDate();" id='threeMonths'
                    value='threeMonths' autocomplete='off' required>
                <label class='btn btn-outline-primary m-0' for='threeMonths'>3 Months</label>

                <input type='radio' class='btn-check' name='reviewDate' onclick="hideDate();" id='sixMonths'
                    value='sixMonths' autocomplete='off' required>
                <label class='btn btn-outline-primary m-0' for='sixMonths'>6 Months</label>

                <input type='radio' class="btn-check" name='reviewDate' onclick="hideDate();" id='oneYear'
                    value='oneYear' autocomplete='off' required>
                <label class='btn btn-outline-primary m-0' for='oneYear'>1 Year</label>

                <input type='radio' class="btn-check" name='reviewDate' onclick="showDate();" id='date' value='date'
                    autocomplete='off' required>
                <label class='btn btn-outline-primary m-0' for='date'>Other</label>
                <input style="display: none;" type="date" id="start" name="custom"
                    min="<?php echo date("Y-m-d", strtotime(' + 1 days'));; ?>">

            </div>
        </div>

        <div class="col-auto">
            <div class='collapse collapse-horizontal custom-date-collapse' id="customDateCollapse">
                <input type='date' placeholder="Choose a date" class='form-control custom-date-input'
                    id='customDateInput' name='customDate' required>
            </div>
        </div>
    </fieldset>

    <div class='row mb-3 justify-content-start'>
        <div class='col-2'>
            <label for='justification' class='form-label'><strong><u>Justification:</u></strong></label>
        </div>
        <div class='col'>
            <textarea class='form-control' id='justification' name="justification" rows='4' required></textarea>
        </div>
    </div>

    <div class=" row mb-3 justify-content-start">
        <div class="col offset-2">
            <button class="btn btn-primary col" name="submit" type="submit">Create exception</button>
        </div>
    </div>
</form>

<script>
function showDate() {
    document.getElementById("start").style.display = "block";
}

function hideDate() {
    document.getElementById("start").style.display = "none";
}
</script>
