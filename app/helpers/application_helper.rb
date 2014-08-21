module ApplicationHelper

  def button_style(which_color)
    case which_color
      when 'red'
        'btn btn-danger btn-lg btn-block'
      when 'green'
        'btn btn-success btn-lg btn-block'
      when 'blue'
        'btn btn-primary btn-lg btn-block'
      when 'orange'
        'btn btn-warning btn-lg btn-block'
      else
        'btn btn-default btn-lg btn-block'
    end
  end

  def table_row_style
    if !self.date_received.nil? && !self.date_resolved.nil?
      return 'success'
    elsif !self.date_received.nil? && self.date_resolved.nil?
      return 'warning'
    else
      return 'default'
    end
  end



end
