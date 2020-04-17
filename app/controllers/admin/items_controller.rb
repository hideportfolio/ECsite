

class Admin::ItemsController < Admin::ApplicationController
  def index
	@items = Item.page(params[:page])
  end

  def new
  	@item = Item.new
  end

  def create
  	@item = Item.new(item_params)
  	if @item.save!
  		redirect_to admin_items_path, notice: "successfully created item!"#保存された場合の移動先を指定。
  	else
  		render 'new'
  	end
  end

 private

  def item_params
  	params.require(:item).permit(:name, :introduction,:is_sale,:genre_id,:image,:price_before_tax)
  end

end

