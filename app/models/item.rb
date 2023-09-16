class Item < ApplicationRecord
  has_many :reviews, dependent: :destroy

  VALID_STATUSES = ['active', 'inactive']

  validates :status, inclusion: { in: VALID_STATUSES }

  validates :name, presence: true
  validates :price, presence: true

  scope :active, -> { where(status: 'active') }

  def active?
    status == 'active'
  end

  def price=(val)
    write_attribute(:price, (val.to_f * 100).to_i)
  end
end
