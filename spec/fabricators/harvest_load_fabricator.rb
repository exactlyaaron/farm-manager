Fabricator(:harvest_load) do
  field
  date Date.today
  receipt_number { sequence(:receipt_number) { |i| "#{i}" } }
  price_per_bushel 1
  bushels_sold 10
end