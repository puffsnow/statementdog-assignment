class UniversalError < StandardError
  attr_reader :error_message, :redirect_path, :render_page

  def initialize(error_message, redirect_path: nil, render_page: nil)
    @error_message = error_message
    @redirect_path = redirect_path
    @render_page = render_page
  end
end
