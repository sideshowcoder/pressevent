module ApplicationHelper
  def nav_bar_link_to name, path, opts = {}
    current_page?(path) ? active_class = "active" : active_class = ""
    content_tag :li, class: active_class do
      link_to name, path, opts
    end
  end

  def bootstrap_class_for flash_type
    case flash_type.to_sym
    when :success
      "alert-success"
    when :error
      "alert-danger"
    when :alert
      "alert-danger"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def form_errors object
    return '' if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: object.errors.count,
                      resource: object.class.model_name.human.downcase)

    html = <<-HTML
    <div class="devise-alert alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h4>#{sentence}</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
