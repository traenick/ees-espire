module ApplicationHelper

  def button_style(which_color)
    case which_color
      when 'red'
        'btn btn-danger btn-lg'
      when 'green'
        'btn btn-success btn-lg'
      when 'blue'
        'btn btn-primary btn-lg'
      when 'orange'
        'btn btn-warning btn-lg'
      else
        'btn btn-default btn-lg'
    end
  end


end
