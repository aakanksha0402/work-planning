class Api::V1::ShiftSerializer < ActiveModel::Serializer
  attributes :id, :shift_name, :work_date
  belongs_to :worker
end
