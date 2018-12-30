class Order < ApplicationRecord
  scope :shipped, -> { where.not(shipped_at: nil).order(:shipped_at) }
  scope :unshipped, -> { where(shipped_at: nil) }

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
