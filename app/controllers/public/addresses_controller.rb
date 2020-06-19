class Public::AddressesController < ApplicationController
  before_action :authenticate_customer
  before_action :ensure_customer, only: [:edit, :update, :destroy]
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  private

  def ensure_customer
    @address = current_customer.addresses.find_by(id: params[:id])
    unless @address
      redirect_to addresses_path
    end
  end

  def address_params
    params.require(:address).permit(:postal_code, :destination, :name)
  end
end
