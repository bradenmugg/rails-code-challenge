class Widget < ApplicationRecord
  validates :name, :msrp, presence: true
end
