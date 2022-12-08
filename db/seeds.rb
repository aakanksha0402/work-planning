10.times do
  worker = Worker.create(name: Faker::Name.unique.name)
  Shift.create(worker: worker, shift_name: 'Shift A', work_date: '22/12/2022')
end

