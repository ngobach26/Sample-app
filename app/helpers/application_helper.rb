module ApplicationHelper
  def full_title(title = '')
    base_title = I18n.t 'base_title'
    if title.blank?
      base_title
    else
      title + ' | ' + base_title
    end
  end

  def message_case(key)
    case key
    when "notice"
      :success
    when "info"
      :info
    when "warn"
      :warning
    when "alert"
      :danger
    end
  end
end
