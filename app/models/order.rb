class Order < ApplicationRecord
  scope :shipped, -> { where.not(shipped_at: nil).order(:shipped_at) }
  scope :unshipped, -> { where(shipped_at: nil) }
  has_many :line_items
  accepts_nested_attributes_for :line_items, reject_if: :all_blank?, allow_destroy: true
  validates_associated :line_items

  def expedited?
    @expedite
  end

  def returnable?
    @returns
  end

  def settings(opts = {})
    @expedite = opts[:expedite].presence
    @returns = opts[:returns].presence
    @warehouse = opts[:warehouse].presence
  end

  def shipped?
    shipped_at.present?
  end

  def warehoused?
    @warehouse
  end

end
