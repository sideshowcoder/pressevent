desc "run tests for features"
Rails::TestTask.new("test:features" => "test:prepare") do |t|
  t.pattern = "test/features/**/*_test.rb"
end

desc "run tests for services"
Rails::TestTask.new("test:services" => "test:prepare") do |t|
  t.pattern = "test/services/**/*_test.rb"
end
