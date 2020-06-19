class Public::CustomersController < ApplicationController
  before_action :authenticate_customer
  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number)
  end
end
