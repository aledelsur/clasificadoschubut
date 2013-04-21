$(document).ready(function() {
  
  $('.step1-submit').click(function(){
    var value = $("#publication_city_id").val()
    if (value != ""){
      $.post("/publications/new/to-first", $("#new_publication").serialize());
    }
    return false;
  });

});
