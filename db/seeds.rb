# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# Examples:
# #
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Destroy database.."
sleep(1)
Doctor.destroy_all
Appointment.destroy_all
City.destroy_all
JoinTableDoctorsSpecialty.destroy_all
Patient.destroy_all
Specialty.destroy_all
puts "Database destroyed"
sleep(1)
puts "Delete from sqlite_sequence..."
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'doctors'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'appointments'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'cities'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'patients'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'specialties'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'join_table_doctors_specialties'")
sleep(1)
puts "Sucess, all DB deleted"
sleep(1)
puts "generate new DB..."
puts ""
puts "_______________________________"
puts ""
sleep(1.5)

10.times do
	city = City.create!(name: Faker::Address.city)
	puts "city #{city.name}"
end

puts "_______________________________"
puts ""

sleep(1)

5.times do
	specialty = Specialty.create!(name: Faker::Job.field)
	puts "specialty #{specialty.name}"
end

puts "_______________________________"
puts ""

sleep(1)

10.times do 
   doctor = Doctor.create!(city_id: City.all.sample.id, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, zip_code: Faker::Address.zip_code)
   puts "Doctor #{doctor.first_name} #{doctor.last_name} (city_id #{doctor.city_id})"
 end

 puts "_______________________________"
puts ""

sleep(1)

10.times do 
  patient = Patient.create!(city_id: City.all.sample.id, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  puts "Patient #{patient.first_name} #{patient.last_name}"
end

puts "_______________________________"
puts ""

sleep(1)

10.times do 
  appointment = Appointment.create!(doctor_id: Doctor.all.sample.id, patient_id: Patient.all.sample.id, city_id: City.all.sample.id, date: Faker::Date.forward(42))
  puts "appointment #{appointment.date}"
end

puts "_______________________________"
puts ""

sleep(1)

10.times do 
  join_table_doctors_specialty = JoinTableDoctorsSpecialty.create!(doctor_id: Doctor.all.sample.id, specialty_id: Specialty.all.sample.id)
  puts "Join Table #{join_table_doctors_specialty}"
end

puts "_______________________________"
puts ""
sleep(2)
puts "ALL GOOD, DB fresh and ready to be explored as life"