class ApplicationController < ActionController::Base
  rescue_from UniversalError do |e|
    flash[:alert] = e.error_message

    if e.redirect_path.present?
      redirect_to e.redirect_path
    elsif e.render_page.present?
      render e.render_page
    else
      redirect_to root_path
    end
  end
end
