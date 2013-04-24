$(document).ready(function() { 

  $('#slider-left').cycle({ 
      fx:    'fade',
      speed:  'fast', 
      timeout: 3000, 
      next:   '#nav-slider-left-next', 
      prev:   '#nav-slider-left-prev',
      pause:   1
  });

  $('.sort').click(function(){
    var type = $(this).attr("type");
    $.post("/order/"+type);
    return false;
  });

  $('.other-image').hover(function(){
    var image_id_to_show = $(this).attr("id");
    var image_to_hide = $('.current-image');
    image_to_hide.removeClass('.current-image');
    image_to_hide.addClass('.not-current-image');
    //image_to_hide.hide();

    var image_to_show = $('#big-'+image_id_to_show);

    return false;
  });

  $('.contact-seller-btn').click(function(){
    $('.contact-seller-options').show();
    var offset_from_top = $(".contact-seller").offset().top

    $('html, body').animate({ scrollTop: offset_from_top }, 'fast'); 
    return false;
  })

});

