# Create some basic data which needs to be present in the database
# so we can run the tests

# create the default user if not present
unless User.find_for_authentication(email: 'nobody@example.com')
  User.create!(email: 'nobody@example.com', password: 'password', password_confirmation: 'password')
end
