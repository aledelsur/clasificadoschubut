//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

$(document).ready(function(){
  
  $("#auto_complete").keyup(function(){
    var str = $("#auto_complete").val();
    $.post("/search-words/keypress", {str:str});
    return false;
  });

});

