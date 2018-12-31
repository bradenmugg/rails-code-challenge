class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :widget
  accepts_nested_attributes_for :widget
  validates_associated :widget

  validates :order, :quantity, :unit_price, :widget, presence: true
end
