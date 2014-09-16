Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password { "password1" }
  budget { 0 }
end