document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('[data-bs-toggle="modal"]');
  
  buttons.forEach(button => {
    button.addEventListener('click', function () {
      const data_address_id = this.getAttribute('data-id');
      const data_address_recipient_name = this.getAttribute('data-recipient');
      const data_address_phone_number = this.getAttribute('data-phone');
      const data_address_street = this.getAttribute('data-street');
      const data_address_city = this.getAttribute('data-city');
      const data_address_state = this.getAttribute('data-state');
      const data_address_pin_code = this.getAttribute('data-pincode');
      const data_address_default = this.getAttribute('data-default');

      const address_id = document.getElementById('address_id');
      const address_recipient_name = document.getElementById('address_recipient_name');
      const address_phone_number = document.getElementById('address_phone_number');
      const address_street = document.getElementById('address_street');
      const address_city = document.getElementById('address_city');
      const address_state = document.getElementById('address_state');
      const address_pin_code = document.getElementById('address_pin_code');
      const address_default = document.getElementById('address_default');

      if (data_address_id) {
        address_id.value = data_address_id; 
        address_recipient_name.value = data_address_recipient_name
        address_phone_number.value = data_address_phone_number
        address_street.value = data_address_street
        address_city.value = data_address_city 
        address_state.value = data_address_state
        address_pin_code.value = data_address_pin_code
        address_default.checked = (data_address_default === 'true'); 
      }
    });
  });
});
