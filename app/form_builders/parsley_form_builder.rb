class ParsleyFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, to: :@template

  def text_field(name, options={})
    content_tag :li, class: "field" do
      pretty_name = options[:label]? options[:label].downcase : name
      required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
      length_validated = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::LengthValidator }
      options.reverse_merge! "data-required" => "true" if required
      if options[:input_type] == "username"
        options.reverse_merge! "data-required-message" => ""
        options.reverse_merge! "data-type" => "alphanum"
        options.reverse_merge! "data-type-alphanum-message" => "Username must contain alphanumeric characters only"
        options.reverse_merge! "data-rangelength" => "[#{MIN_USER_USERNAME_LENGTH}, #{MAX_USER_USERNAME_LENGTH}]"
        options.reverse_merge! "data-rangelength-message" => "Please enter a username between 2 and 16 characters long"
        options.reverse_merge! "data-validation-minlength" => 2
      else
        if required
          options.reverse_merge! "data-required-message" => "Please enter a #{pretty_name}"
        end
        if length_validated
          max_length = "MAX_#{object.class.name.upcase}_#{name.upcase}_LENGTH".constantize
          options.reverse_merge! "data-maxlength" => max_length
          options.reverse_merge! "data-maxlength-message" => "#{pretty_name.capitalize} must be #{max_length} characters or less"
        end
      end
      field_label(name, options) + super(name, options)
    end
  end

  def text_area(name, options={})
    content_tag :li, class: "field" do
      pretty_name = options[:label]? options[:label].downcase : name
      length_validated = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::LengthValidator }
      if length_validated
        max_length = "MAX_#{object.class.name.upcase}_#{name.upcase}_LENGTH".constantize
        options.reverse_merge! "data-maxlength" => max_length
        options.reverse_merge! "data-maxlength-message" => "#{pretty_name.capitalize} must be #{max_length} characters or less"
      end
      field_label(name, options) + super(name, options)
    end
  end

  def filepicker_field(name, *args)
    content_tag :li, class: "field" do
      options = args.extract_options!
      options[:button_text] = "Select a file to upload"
      options[:button_class] = "btn"
      options[:dragdrop] = true
      options[:drag_text] = "or drop files here"
      options[:mimetypes] = ["image/png, image/jpeg"]
      options[:services] = ["COMPUTER, FACEBOOK, GOOGLE_DRIVE, DROPBOX, PICASA, INSTAGRAM, FLICKR"]
      field_label(name, options) + super(name, options)
    end
  end

  def email_field(name, options={})
    content_tag :li, class: "field" do
      required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
      options.reverse_merge! "data-required" => true if required
      options.reverse_merge! "data-type" => "email"
      options.reverse_merge! "data-error-message" => "Please enter a valid email address"
      options.reverse_merge! "data-trigger" => "change"
      options.reverse_merge! "data-validation-minlength" => 1
      field_label(name, options) + super(name, options)
    end
  end

  def password_field(name, options={})
    content_tag :li, class: "field" do
      required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
      options.reverse_merge! "data-required" => true if required
      length_validated = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::LengthValidator }
      options.reverse_merge! "data-rangelength" => "[#{MIN_USER_PASSWORD_LENGTH}, #{MAX_USER_PASSWORD_LENGTH}]" if length_validated
      options.reverse_merge! "data-error-message" => "Please enter a password between #{MIN_USER_PASSWORD_LENGTH} and #{MAX_USER_PASSWORD_LENGTH} characters long"
      field_label(name, options) + super(name, options)
    end
  end

  def select(name, *args)
    content_tag :li, class: "field" do
      field_label(name, *args) + super(name, *args)
    end
  end

  def submit(name, *args)
    content_tag :li, class: "actions" do
      options = args.extract_options!
      options[:class] = "btn"
      super(name, options)
    end
  end

  private

    def field_label(name, *args)
      options = args.extract_options!
      label(name, options[:label])
    end

    def objectify_options(options)
      super.except(:label)
    end
end