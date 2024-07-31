module ApplicationHelper
  def full_title(title = '')
    base_title = I18n.t 'base_title'
    title.blank? ? base_title : "#{title} | #{base_title}"
  end

  def message_case(key)
    case key
    when 'notice'
      :success
    when 'info'
      :info
    when 'warn'
      :warning
    when 'alert'
      :danger
    else
      key
    end
  end
end
