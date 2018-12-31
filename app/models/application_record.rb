class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # replacement for #all_blank that recognizes double nested blank attributes
  def all_blank?(attributes)
    attributes.all? do |key, value|
      key == '_destroy' || value.blank? ||
      value.is_a?(Hash) && all_blank?(value)
    end
  end
end
