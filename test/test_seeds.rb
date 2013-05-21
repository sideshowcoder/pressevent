# Create some basic data which needs to be present in the database
# so we can run the tests

User.create!(email: 'nobody@example.com', password: 'password', password_confirmation: 'password')
