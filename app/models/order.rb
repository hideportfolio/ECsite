class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :destination, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :grand_total, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_deposit: 0, confirm_deposit: 1, in_production: 2, preparing_shipment: 3, shipped: 4 }

  def are_all_details_completed?
    result = false
    if order_details.completed.count == order_details.count
      result = true
    end
    result
  end
end
