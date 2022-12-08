10.times do
  worker = Worker.create(name: Faker::Name.unique.name)
  Shift.create(worker: worker, shift_name: '0-8', work_date: '2022/12/01')
end

