<?php

/**
 * @param $reviewDate "date as unix timestamp"
 * @return void
 */
function getExceptionForm(string $reviewDate = "", string $justification = "") {
  include(dirname(__DIR__) . "/Components/exception-form.html");
}
