class Admin::HomesController < ApplicationController
  before_action :authenticate_admin
  def top
    beginning_of_today = Time.now.in_time_zone("Tokyo").beginning_of_day
    beginning_of_tomorrow = beginning_of_today.tomorrow
    @count = Order.where(created_at: beginning_of_today...beginning_of_tomorrow).count
  end

  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @result = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'customer'
      if method == 'forward'
        Customer.where(
          'last_name LIKE ? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE?',
          "#{content}%", "#{content}%", "#{content}%", "#{content}%"
        )
      elsif method == 'backward'
        Customer.where(
          'last_name LIKE ? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE?',
          "%#{content}", "%#{content}", "%#{content}", "%#{content}"
        )
      elsif method == 'perfect'
        Customer.where(
          'last_name = ? OR first_name = ? OR last_name_kana = ? OR first_name_kana = ?',
          content, content, content, content
        )
      else # partial
        Customer.where(
          'last_name LIKE ? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE?',
          "%#{content}%", "%#{content}%", "%#{content}%", "%#{content}%"
        )
      end
    elsif model == 'item'
      if method == 'forward'
        Item.where('name LIKE ?', content + '%').includes(:genre)
      elsif method == 'backward'
        Item.where('name LIKE ?', '%' + content).includes(:genre)
      elsif method == 'perfect'
        Item.where(name: content).includes(:genre)
      else # partial
        Item.where('name LIKE ?', '%' + content + '%').includes(:genre)
      end
    end
  end
end
