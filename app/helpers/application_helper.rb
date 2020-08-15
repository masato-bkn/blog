module ApplicationHelper
  def format_time(time)
    time.strftime('%Y/%B/%d')
  end
end
