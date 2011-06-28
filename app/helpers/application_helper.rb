module ApplicationHelper
  
  #returns a titleon a per-page basis
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if base_title.nil?
      base_title
    else
      "#{base_title} | #{@page_title}"
    end
  end
end
