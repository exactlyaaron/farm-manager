Fabricator(:field) do
  user
  name { sequence(:name) { |i| "My Field #{i}" } }
  crop "Placeholder"
  crop_price 5
  acreage 25
  notes "notes about the field"
end