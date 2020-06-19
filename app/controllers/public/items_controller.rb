class Public::ItemsController < ApplicationController
  def top
    @genres = Genre.only_active.includes(:items)
    @items = []
    @genres.each do |genre|
      item = genre.items.last
      if item
        @items << item
      end
    end
  end

  def index
    @genres = Genre.only_active
    if params[:genre_id]
      @genre = @genres.(id: params[:genre_id])
      if @genre
        all_items = @genre.items
        @items = all_items.page(params[:page]).per(12)
        @all_items_count = all_items.count
      else
        redirect_to items_path
      end
    else
      all_items = Item.where_genre_active.includes(:genre)
      @items = all_items.page(params[:page]).per(12)
      @all_items_count = all_items.count
    end
  end

  def show
    @item = Item.where_genre_active.find(params[:id])
    @genres = Genre.only_active
    @cart_item = CartItem.new
  end
end
