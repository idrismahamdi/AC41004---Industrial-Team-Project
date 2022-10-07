import * as bootstrap from 'bootstrap'

const dateSelection = document.getElementsByName('reviewDate');
const customDateElement = document.getElementById('customDateCollapse');
const customDateInput = document.getElementById('customDateInput');
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

document.getElementById('custom').click();
