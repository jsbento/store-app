class Review < ApplicationRecord
  belongs_to :item

  VALID_STATUSES = ['pending', 'approved', 'rejected']

  validates :author, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: VALID_STATUSES }

  scope :approved, -> { where(status: 'approved') }
  scope :pending, -> { where(status: 'pending') }
  scope :rejected, -> { where(status: 'rejected') }

  def approved?
    status == 'approved'
  end
end
