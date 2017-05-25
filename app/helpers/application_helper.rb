module ApplicationHelper

  def show_field_error(model, field)
    s=""

    if !model.errors[field].empty?
      s =
          <<-EOHTML
           <div id="error_message">
             #{model.errors[field][0]}
           </div>
      EOHTML
    end

    s.html_safe
  end

  def gps_as_json(gpss)
    gpss.collect do |gps|
      {
          :lat => gps.lat,
          :lng => gps.lng,
          :day => gps.day,
          :hour => gps.hour,
          :id => gps.id
      }
    end.to_json
  end



end
