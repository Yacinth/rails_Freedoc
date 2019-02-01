# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# Examples:
# #
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

p "destroy database"
Doctor.destroy_all
Appointment.destroy_all
City.destroy_all
JoinTableDoctorsSpecialty.destroy_all
Patient.destroy_all
Specialty.destroy_all
p "ok"
p "delete from sqlite_sequence..."
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'doctors'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'appointments'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'cities'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'patients'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'specialties'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'join_table_doctors_specialties'")
p "Sucess, all DB deleted"


p "generate new DB..."

10.times do
	city = City.create!(name: Faker::Address.city)
	p "city #{city.name}"
end

5.times do
	specialty = Specialty.create!(name: Faker::Job.field)
	p "specialty #{specialty.name}"
end

10.times do 
   doctor = Doctor.create!(city_id: City.all.sample.id, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, zip_code: Faker::Address.zip_code)
   p "Doctor #{doctor.first_name} #{doctor.last_name} (city_id #{doctor.city_id})"
 end

10.times do 
  patient = Patient.create!(city_id: City.all.sample.id, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  p "Patient #{patient.first_name} #{patient.last_name}"
end

10.times do 
  appointment = Appointment.create!(doctor_id: Doctor.all.sample.id, patient_id: Patient.all.sample.id, city_id: City.all.sample.id, date: Faker::Date.forward(42))
  p "appointment #{appointment.date}"
end

10.times do 
  join_table_doctors_specialty = JoinTableDoctorsSpecialty.create!(doctor_id: Doctor.all.sample.id, specialty_id: Specialty.all.sample.id)
  p "Join Table #{join_table_doctors_specialty}"
end