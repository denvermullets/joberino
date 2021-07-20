class ApplicationController < ActionController::Base
  # possible before_action for updating last sign in time
  # before_action sign_in(current_user, force: true)

  protect_from_forgery with: :exception
end
