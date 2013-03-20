module ApplicationHelper
  def hidden_div_if(condition, attribytes = {}, &block)
    if condition
      attribytes["style"] = "display : none"
    end
    content_tag("div", attribytes, &block)
  end
end
