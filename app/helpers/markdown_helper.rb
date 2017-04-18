module MarkdownHelper
  def markdown(text)
    rc = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    rc.render(text).html_safe
  end
end
