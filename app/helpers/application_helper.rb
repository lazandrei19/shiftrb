module ApplicationHelper
  def md_render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true), autolink: true, tables: true)
    markdown.render(text).html_safe
  end

  def like_or_likes(count)
    count == 1 ? "likes" : "like"
  end

  def unread
    current_user.unread > 0
  end

  def first_time
    if session[:first_time]
      true
    elsif cookies[:first_time]
      false
    else
      cookies[:first_time] = true
      session[:first_time] = true
      true
    end
  end
end
