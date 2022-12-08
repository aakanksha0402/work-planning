class Worker < ApplicationRecord
  has_many :shifts, dependent: :destroy

  validates :name, presence: true
end
