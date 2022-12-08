class Api::V1::ShiftSerializer < ActiveModel::Serializer
  attributes :id, :shift_name, :formatted_date
  belongs_to :worker

  def formatted_date
    object.work_date.to_s(:custom_datetime)
  end
end
