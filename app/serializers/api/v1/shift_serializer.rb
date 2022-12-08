class Api::V1::ShiftSerializer < ActiveModel::Serializer
  attributes :shift_name, :work_date
  belongs_to :worker
end
