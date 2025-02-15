class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  rescue_from StandardError, with: :handle_generic_error

  private

  def handle_not_found(exception)
    render_error_page("404", "Record not found: #{exception.message}")
  end

  def handle_invalid_record(exception)
    render_error_page("422", "Invalid record: #{exception.message}")
  end

  def handle_generic_error(exception)
    render_error_page("500", "An error occurred: #{exception.message}")
  end

  def render_error_page(status_code, message)
    respond_to do |format|
      format.html { render "errors/#{status_code}", status: status_code, locals: { error_message: message } }
      format.json { render json: { error: message }, status: status_code }
    end
  end
end
