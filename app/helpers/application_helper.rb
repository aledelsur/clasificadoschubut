module ApplicationHelper
  require "cgi"

  def elapsed_time(old_time) 
    val = Time.now - old_time
    if val < 10 then
      result = 'hace unos instantes'
    elsif val < 40  then
      result = 'hace menos de ' + (val * 1.5).to_i.to_s.slice(0,1) + '0 segundos'
    elsif val < 60 then
      result = 'hace menos de un minuto'
    elsif val < 60 * 1.3  then
      result = "hace 1 minuto"
    elsif val < 60 * 50  then
      result = "hace #{(val / 60).to_i} minutos"
    elsif val < 60  * 60  * 1.4 then
      result = 'hace una hora'
    elsif val < 60  * 60 * (24 / 1.02) then
      hours = (val / 60 / 60 * 1.02).to_i
      if hours == 1
        result = "hace aproximadamente #{hours.to_s} hora"                
      else
        result = "hace aproximadamente #{hours.to_s} horas"
      end
    else
      result = old_time.strftime("%B %d %Y, a las %H:%M %p")
      
    end
    result
  end

  def safe(content)
    #plain_text = strip_tags(html_input)
    "#{ CGI::unescapeHTML(content) }".html_safe
  end

  def sortable(column, title=nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end


end
