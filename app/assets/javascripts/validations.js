$(document).ready(function() {


/////////////////////////////////////
/////////////////////////////////////
// START FORM VALIDATIONS - THIS IS THE SAME CODE FOUND IN details.js.erb //
/////////////////////////////////////
/////////////////////////////////////

  $('.description_area').wysihtml5({
    "font-styles": false,
    "link": false,
    "image": false,
    "events": { "blur": function() { 
        if(editor.getValue() == ""){
          wrong_description();
        }else{
          ok_description();
        }
      } 
    }
  });


  if ($(".title-input-field").val() == ""){ //sometimes there is an email set in the input
    var ok_title_field = false;
  }else{
    var ok_title_field = true;
  }

  if ($(".price-input-field").val() == ""){ //sometimes there is an email set in the input
    var ok_price_field = false;
  }else{
    var ok_price_field = true;
  }

  if (editor.getValue() == ""){ //sometimes there is an email set in the input
    var ok_description_field = false;
  }else{
    var ok_description_field = true;
  }

  
  if ($(".email-input-field").val() == ""){ //sometimes there is an email set in the input
    var ok_email_field = false;
  }else{
    var ok_email_field = true;
  }
  //HACER CONDITION if else

  if($('.condition-input-field').is(':checked')) {
    var ok_condition_field = true;
  }else{
    var ok_condition_field = false;
  }


  $(".title-input-field").focusout(function(){
    if ($(".title-input-field").val() == ""){
      wrong_title();
    }else{
      ok_title();
    }
  });

  $(".price-input-field").focusout(function(){
    if ($(".price-input-field").val() == ""){
      wrong_price();
    }else{ // campo de precio lleno
      ok_price();
    }
  });

  $(".email-input-field").focusout(function(){
    var value = $(".email-input-field").val();
    if (value == ""){
      wrong_email();
    }else if (!isValidEmailAddress(value)){
      wrong_email_format();
    }else{
      ok_email();
    }
  });  

  $(".condition-input-field").click(function(){
    ok_condition();
  });  


$(".submit-form").click(function(){
  var count = 0;
  if (ok_title_field == false){
    wrong_title();
  }else{
    ok_title();
    count++;
  }
  if (ok_price_field == false){
    wrong_price();
  }else{
    ok_price();
    count++;
  }
  if (ok_description_field == false){
    wrong_description();
  }else{
    ok_description();
    count++;
  }
  if (ok_email_field == false){
    var value = $(".email-input-field").val();
    if (value == ""){
      wrong_email();
    }else if (!isValidEmailAddress(value)){
      wrong_email_format();
    }
  }else{
    ok_email();
    count++;
  }
  if (ok_condition_field == false){
    wrong_condition();
  }else{
    ok_condition();
    count++;
  }

  if (count == 5){ // the five validations are ok
    $(".not-all-fields-completed").hide();
    $("form").submit();
  }else{
    $(".not-all-fields-completed").show();
    return false;
  }
});

function isValidEmailAddress(email) {
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(email);
};

function wrong_title(){
  ok_title_field = false;
  $(".title-row").addClass("required-field");
  $(".ok-field-title").hide();
  $(".wrong-field-title").show();
}

function ok_title(){
  ok_title_field = true;
  $(".title-row").removeClass("required-field");
  $(".ok-field-title").show();
  $(".wrong-field-title").hide();
}

function wrong_price(){
  ok_price_field = false;
  $(".price-and-currency").addClass("required-field");
  $(".ok-field-price-currency").hide();
  $(".wrong-field-price-currency").show();
}

function ok_price(){
  ok_price_field = true;
  $(".price-and-currency").removeClass("required-field");
  $(".ok-field-price-currency").show();
  $(".wrong-field-price-currency").hide();
}

function wrong_description(){
  ok_description_field = false;
  $("#publication_description_input").addClass("border-rich"); 
  $(".description-rich").addClass("required-field"); 
  $(".ok-field-description").hide();
  $(".wrong-field-description").show();
}

function ok_description(){
  ok_description_field = true;
  $("#publication_description_input").removeClass("border-rich");
  $(".description-rich").removeClass("required-field");
  $(".ok-field-description").show();
  $(".wrong-field-description").hide();
}

function wrong_email(){
  ok_email_field = false;
  $(".email-row").addClass("required-field");
  $(".ok-field-email").hide();
  $(".wrong-field-email").show();
}

function wrong_email_format(){
  ok_email_field = false;
  $(".email-row").addClass("required-field");
  $(".ok-field-email").hide();
  $(".wrong-field-email-format").show();
}

function ok_email(){
  ok_email_field = true;
  $(".email-row").removeClass("required-field");
  $(".ok-field-email").show();
  $(".wrong-field-email").hide();
  $(".wrong-field-email-format").hide();
}

function wrong_condition(){
  ok_condition_field = false;
  $(".condition-row").addClass("required-field");
  $(".wrong-field-condition").show();
}

function ok_condition(){
  ok_condition_field = true;
  $(".ok-field-condition").show();
  $(".condition-row").removeClass("required-field");
  $(".wrong-field-condition").hide();
}



});
