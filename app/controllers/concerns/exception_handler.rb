module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      flash[:alert] = "Could not create user; #{e.message}"
      redirect_to new_user_path
    end
  end
end