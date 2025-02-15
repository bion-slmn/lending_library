# app/controllers/errors_controller.rb
class ErrorsController < ApplicationController
    def not_found
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/404.html", status: :not_found }
        format.json { render json: { error: "Not Found" }, status: :not_found }
      end
    end
end
