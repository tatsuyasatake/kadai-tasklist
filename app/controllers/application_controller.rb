class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to toppages#index
    end
  end
  
  def after_sign_in_path_for(resource)
    root_path
  end
  
  def counts(user)
    @count_tasks = user.tasks.count
  end
end
