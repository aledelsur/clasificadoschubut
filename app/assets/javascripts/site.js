$(document).ready(function() { 

  $('#slider-left').cycle({ 
      fx:    'fade',
      speed:  'fast', 
      timeout: 3000, 
      next:   '#nav-slider-left-next', 
      prev:   '#nav-slider-left-prev',
      pause:   1
  });

  $('#slider-left-publication').cycle({ 
      fx:    'fade',
      speed:  'fast', 
      timeout: 6000, 
      next:   '#nav-slider-next', 
      prev:   '#nav-slider-prev',
      pause:   1
  });


  $('.sort').click(function(){
    var type = $(this).attr("type");
    $.post("/order/"+type);
    return false;
  });


  $('.other-image').mouseover(function() {
    var src = $(this).children().attr("src");    
    $(".current-image").fadeOut('fast', function() {
      $(this).attr("src",src).fadeIn('slow');
    });
    return false;
  });


  $('.contact-seller-btn').click(function(){
    $('.contact-seller-options').show();
    var offset_from_top = $(".contact-seller").offset().top

    $('html, body').animate({ scrollTop: offset_from_top }, 'fast'); 
    return false;
  })

  $('.submit-contact-email').click(function(){ // This button is either for contact us and for contact seller
    var name = $('.input-name-field').val();
    var email = $('.input-email-field').val();
    var question = $('.input-question-field').val();

    if (name == "" || email == "" || question == ""){
      $('.not-all-fields-completed').show();
      return false;
    }else{
      $("form").submit();
    }
  });

});

