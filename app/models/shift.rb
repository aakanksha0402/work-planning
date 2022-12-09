class Shift < ApplicationRecord
  enum :shift_name, ['0-8', '8-16', '16-24']

  belongs_to :worker

  validates :shift_name, presence: true
  validate :only_one_shift_per_worker
  validate :shift_date

  def only_one_shift_per_worker
    errors.add(:base, "Double shift in a day is not allowed") if Shift.where(worker: self.worker, work_date: self.work_date).where.not(id: self.id).take
  end

  def shift_date
    Time.parse(work_date.to_s)
  rescue ArgumentError
    errors.add(:base, "Please enter date in YYYY/MM/DD format")
  end
end
