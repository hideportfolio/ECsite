class ApplicationController < ActionController::Base
  protected

  def authenticate_customer
    unless current_customer
      flash[:alert] = 'You need to sign in or sign up before continuing.'
      redirect_to new_customer_session_path
    end
  end

  def authenticate_admin
    unless current_admin
      redirect_to root_path
    end
  end
end
