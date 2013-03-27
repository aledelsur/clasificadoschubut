$(document).ready(function() {
  $('.new-publication-category').click(function(){
    var sub = $(this).attr("sub_cat_id");
    $("#publication_sub_category_id").val(sub);
    $('form').submit();
  });
})
