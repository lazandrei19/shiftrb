module ApplicationHelper
  def md_render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true), autolink: true, tables: true)
    markdown.render(text).html_safe
  end

  def like_or_likes(count)
    count == 1 ? "likes" : "like"
  end
end
