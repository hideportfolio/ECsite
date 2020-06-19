class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin
  before_action :ensure_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.includes(:genre)
    end
    @items = all_items.page(params[:page])
    @all_items_count = all_items.count
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :image, :price, :is_valid)
  end

  def ensure_item
    @item = Item.find_by(id: params[:id])
    unless @item
      redirect_to admin_items_path
    end
  end
end
