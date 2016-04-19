module ApplicationHelper
  def md_render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true), autolink: true, tables: true)
    markdown.render(text).html_safe
  end
end
