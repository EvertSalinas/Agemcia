# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Quotation.delete_all

# Pending
(1..5).each do |n|
  Quotation.create(name: "cotizacion-#{n}", company: "company-#{n}", address: "direccion-#{n}", phone: "#{n}#{n}#{n}#{n}#{n}",
                   event_time:    Date.current, event_date:     Date.current,
                   pickup_time:   Date.current, pickup_date:    Date.current,
                   deliver_time:  Date.current, deliver_date:   Date.current,
                   elaboration_date: Date.current,
                   paid: 'no', state: 'pendiente'
                 )
end

# Completed
(1..5).each do |n|
  Quotation.create(name: "cotizacion-#{n+5}", company: "company-#{n+5}", address: "direccion-#{n+5}", phone: "#{n}#{n}#{n}#{n}#{n}",
                   event_time:    Date.current, event_date:     Date.current,
                   pickup_time:   Date.current, pickup_date:    Date.current,
                   deliver_time:  Date.current, deliver_date:   Date.current,
                   elaboration_date: Date.current,
                   paid: 'no', state: 'completada'
                 )
end

(1..5).each do |n|
  Quotation.create(name: "cotizacion-#{n+10}", company: "company-#{n+10}", address: "direccion-#{n+10}", phone: "#{n}#{n}#{n}#{n}#{n}",
                   event_time:    Date.current, event_date:     Date.current,
                   pickup_time:   Date.current, pickup_date:    Date.current,
                   deliver_time:  Date.current, deliver_date:   Date.current,
                   elaboration_date: Date.current,
                   paid: 'no', state: 'cancelada'
                 )
end
