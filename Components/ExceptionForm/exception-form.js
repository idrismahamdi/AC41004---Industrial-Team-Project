import * as bootstrap from 'bootstrap'

const exceptionForms = document.getElementsByClassName('exception-form');
for (let exceptionForm of exceptionForms) {
    const dateSelection = exceptionForm.getElementsByClassName('btn-check');
    const customDateElement = exceptionForm.getElementsByClassName('custom-date-collapse')[0];
    const customDateInput = exceptionForm.getElementsByClassName('custom-date-input')[0];
    const customDateCollapse = new bootstrap.Collapse(customDateElement, {'toggle': false});

    for (let dateSelectionElement of dateSelection) {
        dateSelectionElement.addEventListener('click', (event) => {
            if (event.target.value === 'custom') {
                customDateCollapse.show();
                customDateInput.setAttribute('required', '');
            } else {
                customDateCollapse.hide();
                customDateInput.removeAttribute('required');
            }
        });
    }

    exceptionForm.getElementsByClassName('custom-date-check')[0].click();
}
