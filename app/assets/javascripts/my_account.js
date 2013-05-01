$(document).ready(function() {

  $('.mark-sold-publication').click(function(){
    var id = $(this).attr("id");
    var option = $(this).attr("option");
    $.post("/mark-as-sold", {id:id, option:option});
    return false;
  });


  $('#compra_venta_publication_title_input').addClass("publication_title_input");
  $('#vehiculos_publication_title_input').addClass("publication_title_input");
  $('#inmuebles_publication_title_input').addClass("publication_title_input");
  $('#servicios_publication_title_input').addClass("publication_title_input");
  $('#cursos_talleres_publication_title_input').addClass("publication_title_input");
  $('#viajes_turismo_publication_title_input').addClass("publication_title_input");
  $('#empleos_publication_title_input').addClass("publication_title_input");

  $('#compra_venta_publication_currency_input').addClass("publication_currency_input");
  $('#vehiculos_publication_currency_input').addClass("publication_currency_input");
  $('#inmuebles_publication_currency_input').addClass("publication_currency_input");
  $('#servicios_publication_currency_input').addClass("publication_currency_input");
  $('#cursos_talleres_publication_currency_input').addClass("publication_currency_input");
  $('#viajes_turismo_publication_currency_input').addClass("publication_currency_input");
  $('#empleos_publication_currency_input').addClass("publication_currency_input");

  $('#compra_venta_publication_price_input').addClass("publication_price_input");
  $('#vehiculos_publication_price_input').addClass("publication_price_input");
  $('#inmuebles_publication_price_input').addClass("publication_price_input");
  $('#servicios_publication_price_input').addClass("publication_price_input");
  $('#cursos_talleres_publication_price_input').addClass("publication_price_input");
  $('#viajes_turismo_publication_price_input').addClass("publication_price_input");
  $('#empleos_publication_price_input').addClass("publication_price_input");

  $('#compra_venta_publication_description_input').addClass("publication_description_input");
  $('#vehiculos_publication_description_input').addClass("publication_description_input");
  $('#inmuebles_publication_description_input').addClass("publication_description_input");
  $('#servicios_publication_description_input').addClass("publication_description_input");
  $('#cursos_talleres_publication_description_input').addClass("publication_description_input");
  $('#viajes_turismo_publication_description_input').addClass("publication_description_input");
  $('#empleos_publication_description_input').addClass("publication_description_input");

  $('#compra_venta_publication_email_input').addClass("publication_email_input");
  $('#vehiculos_publication_email_input').addClass("publication_email_input");
  $('#inmuebles_publication_email_input').addClass("publication_email_input");
  $('#servicios_publication_email_input').addClass("publication_email_input");
  $('#cursos_talleres_publication_email_input').addClass("publication_email_input");
  $('#viajes_turismo_publication_email_input').addClass("publication_email_input");
  $('#empleos_publication_email_input').addClass("publication_email_input");

  $('#compra_venta_publication_condition_input').addClass("publication_condition_input");
  $('#vehiculos_publication_condition_input').addClass("publication_condition_input");
  $('#inmuebles_publication_condition_input').addClass("publication_condition_input");
  $('#servicios_publication_condition_input').addClass("publication_condition_input");
  $('#cursos_talleres_publication_condition_input').addClass("publication_condition_input");
  $('#viajes_turismo_publication_condition_input').addClass("publication_condition_input");
  $('#empleos_publication_condition_input').addClass("publication_condition_input");    
  
  $('#compra_venta_publication_i_am_input').addClass("publication_i_am_input");
  $('#vehiculos_publication_i_am_input').addClass("publication_i_am_input");
  $('#inmuebles_publication_i_am_input').addClass("publication_i_am_input");
  $('#servicios_publication_i_am_input').addClass("publication_i_am_input");
  $('#cursos_talleres_publication_i_am_input').addClass("publication_i_am_input");
  $('#viajes_turismo_publication_i_am_input').addClass("publication_i_am_input");
  $('#empleos_publication_i_am_input').addClass("publication_i_am_input");    

  $('#compra_venta_publication_phone_input').addClass("publication_phone_input");
  $('#vehiculos_publication_phone_input').addClass("publication_phone_input");
  $('#inmuebles_publication_phone_input').addClass("publication_phone_input");
  $('#servicios_publication_phone_input').addClass("publication_phone_input");
  $('#cursos_talleres_publication_phone_input').addClass("publication_phone_input");
  $('#viajes_turismo_publication_phone_input').addClass("publication_phone_input");
  $('#empleos_publication_phone_input').addClass("publication_phone_input");    

  $('#compra_venta_publication_urgent_input').addClass("publication_urgent_input");
  $('#vehiculos_publication_urgent_input').addClass("publication_urgent_input");
  $('#inmuebles_publication_urgent_input').addClass("publication_urgent_input");
  $('#servicios_publication_urgent_input').addClass("publication_urgent_input");
  $('#cursos_talleres_publication_urgent_input').addClass("publication_urgent_input");
  $('#viajes_turismo_publication_urgent_input').addClass("publication_urgent_input");
  $('#empleos_publication_urgent_input').addClass("publication_urgent_input");    


});
