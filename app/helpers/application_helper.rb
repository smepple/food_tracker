module ApplicationHelper

  def full_title(page_title)
    base_title = APP_NAME
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def parsley_form_for(object, options = {}, &block)
    options[:builder] = ParsleyFormBuilder
    options[:html] = { "data-validate" => "parsley",
                       "data-focus" => "first",
                       "data-trigger" => "keyup" }
    form_for(object, options, &block)
  end

  def form_wrapper(&block)
    str = "<fieldset class='liner'><ul>"
    str << capture(&block)
    str << "</ul></fieldset>"
    raw str
  end
end