class Shift < ApplicationRecord
  enum :shift_name, ['Shift A', 'Shift B', 'Shift C']

  belongs_to :worker

  validate :only_one_shift_per_worker, on: :create

  def only_one_shift_per_worker
    errors.add(:base, "Shift already exists for this worker on date #{self.work_date}") if Shift.find_by(worker: self.worker, work_date: self.work_date)
  end
end
