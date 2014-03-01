module ApplicationHelper
  
  def title(page_title)
    if ENV['RAILS_ENV'] == "development"
      content_for :title, "Dev | #{page_title.to_s} | Monopoly banking"
    else
      content_for :title, "#{page_title.to_s} | Monopoly banking"
    end
  end
  
end
