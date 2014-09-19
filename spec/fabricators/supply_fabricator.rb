Fabricator(:supply) do
  user
  kind
  name { sequence(:name) { |i| "My Supply #{i}" } }
  purchase_date Date.today
  vendor "A Reputable Vendor"
  measure "oz"
  quantity 25
  price 10
  unit_cost 0.4

end