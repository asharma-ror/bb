require 'open-uri'
module ApplicationHelper
  def show_messages
    content_tag :div, nil, { :id => 'messages' } do
      flash.collect { |index, value| content_tag(:div, value, {:class => "flash-" + index.to_s}) }.join.html_safe
    end unless flash.blank?
  end
  # To convert the datetime object in specified zone
  # Basically it will be used to display to auction detail(startdate, enddate) in current user/admin's timezone
  def datetime_in_timezone(date, zone='')
    return nil if date.blank?
    return date if zone.blank?
    date.in_time_zone(zone) rescue date
  end
  
  def get_time_zone_from_ip(ip)
    begin 
      # get external IP of rails server if running on localhost
      ip = open("http://ifconfig.me/ip").string.strip if ip == "127.0.0.1"

      location = open("http://api.hostip.info/get_html.php?ip=#{ip}&position=true")
      if location.string =~ /Latitude: (.+?)\nLongitude: (.+?)\n/
        json = open("http://ws.geonames.org/timezoneJSON?lat=#{$1}&lng=#{$2}")
        geo = ActiveSupport::JSON.decode(json)
        return ActiveSupport::TimeZone::MAPPING.index(geo["timezoneId"]) unless geo.empty?
      end
    rescue 
      return nil
    end
  end

  def error_message(err_msg, classes)
    unless err_msg.blank?
      content_tag(:div, :class=> classes) do
        list_items = err_msg.map { |msg| content_tag(:li, msg) }
        content_tag(:ul, content_tag(:a,'&times'.html_safe, :class=>"close", 'data-dismiss'=>"alert") + list_items.join.html_safe, :class=>"set_err_msg" )
      end
    end
  end  
  
end
