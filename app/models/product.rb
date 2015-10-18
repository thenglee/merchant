class Product < ActiveRecord::Base
  validates_presence_of :title, :description, :image_url
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { 
                      only_integer: true,
                      greater_than_or_equal_to: 0
                    }

  has_many :order_items

  def in_stock?
    stock > 0 ? true : false
  end
end
