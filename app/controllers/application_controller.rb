class ApplicationController < ActionController::Base
  include ExceptionHandler

  def registration_error
    'you must be logged in or registered to visit this page'
  end
end
