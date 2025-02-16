
$(function () { $('#jstree_demo_div').jstree(); });
$('#jstree_demo_div').on("changed.jstree", function (e, data) {
  console.log(data.selected);
});
$('#jstree').jstree();
$('#jstree').jstree({
  "plugins": ["wholerow", "checkbox"]
});
$('#html1').jstree();
