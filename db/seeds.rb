# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.create!(
    resident_id: 1,
    address: '東京駅',
    latitude: '35.681298',
    longitude: '139.7640529',
    detail: 'detaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetail'
  )
  
  Cat.create!(
    resident_id: 1,
    address: '大阪府摂津市鶴野４丁目3-34',
    detail: 'detaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetaildetail'
  )