$(document).ready(function() { 

  /*$('#slider-left').cycle({ 
      fx:    'fade',
      speed:  'fast', 
      timeout: 3000, 
      next:   '#nav-slider-left-next', 
      prev:   '#nav-slider-left-prev',
      pause:   1
  });*/

  $('.sort').click(function(){
    var type = $(this).attr("type");
    $.post("/order/"+type);
    return false;
  });

  $('.other-image').hover(function(){
    var image_id_to_show = $(this).attr("id");
    var image_to_hide = $('.current-image');
    image_id_to_hide.removeClass('.current-image');
    image_id_to_hide.addClass('.not-current-image');
    return false;
  });

});

