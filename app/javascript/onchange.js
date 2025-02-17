document.addEventListener('DOMContentLoaded', function () {
  document.getElementById("order_item_status").onchange=function(e){
    document.getElementById("frm").submit();
  }
})