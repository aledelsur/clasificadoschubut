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

});

