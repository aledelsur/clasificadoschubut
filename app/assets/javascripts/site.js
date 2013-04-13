$(document).ready(function() { 


    // $('div.box-emphasize img').lazyload({ 
    //     placeholder : 'img/image.jpg',
    //     effect : 'fadeIn',
    //     threshold : 100
    // });        

    // // jquery featured content slider
    // $('#featured > ul').tabs({fx:{opacity: 'toggle'}}).tabs('rotate', 7000, true);



 // $("img.lazy").lazyload({ effect : "fadeIn"});

        $('#slider-left').cycle({ 
            fx:    'fade',
            speed:  'fast', 
            timeout: 3000, 
            next:   '#nav-slider-left-next', 
            prev:   '#nav-slider-left-prev',
            pause:   1
        });



});


