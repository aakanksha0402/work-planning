class Shift < ApplicationRecord
  enum :shift_name, ['Shift A', 'Shift B', 'Shift C']

  belongs_to :worker

  validate :only_one_shift_per_worker, on: :create
  validates :shift_name, :work_date, presence: true

  def only_one_shift_per_worker
    errors.add(:base, "Double shift in a day is not allowed") if Shift.find_by(worker: self.worker, work_date: self.work_date)
  end
end
