class ItemsController < ApplicationController
	def index
		@items = Item.page(params[:page]).where(is_sale: 'true')
		@genres = Genre.where(is_active: 'true')
	end
end
