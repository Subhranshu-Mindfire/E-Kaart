document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('[data-bs-toggle="modal"]');
  buttons.forEach(button => {
    button.addEventListener('click', function () {
      const productId = this.getAttribute('data-id');
      const productName = this.getAttribute('data-name');
      const productIdElement = document.getElementById('product_stock_product_id');
      if (productIdElement) {
        productIdElement.value = productId;
      }
    });
  });
});


