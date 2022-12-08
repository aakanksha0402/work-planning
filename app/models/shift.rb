class Shift < ApplicationRecord
  enum :shift_name, ['0-8', '8-16', '16-24']

  belongs_to :worker

  validates :shift_name, presence: true
  validate :only_one_shift_per_worker, on: :create
  validate :shift_date

  def only_one_shift_per_worker
    errors.add(:base, "Double shift in a day is not allowed") if Shift.find_by(worker: self.worker, work_date: self.work_date)
  end

  def shift_date
    Time.parse(work_date.to_s)
  rescue ArgumentError
    errors.add(:base, "Please enter date in YYYY/MM/DD format")
  end
end
