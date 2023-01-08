# This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

#   Character.create(name: 'Luke', movie: movies.first)

Attendance.create(
  user_id: '4',

  attendance_time: Time.now,

  date: Time.now,

  start_time: Time.now,

  end_time: Time.now,

  end_default_time: Time.now,

  rest_time: Time.now,

  actual_time: Time.now,

  overtime: Time.now,

  approval_flag: true
)
