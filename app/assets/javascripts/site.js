$(document).ready(function() { 

  $('#slider-left').cycle({ 
      fx:    'fade',
      speed:  'fast', 
      timeout: 3000, 
      next:   '#nav-slider-left-next', 
      prev:   '#nav-slider-left-prev',
      pause:   1
  });


});

