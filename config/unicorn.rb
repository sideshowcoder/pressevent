# helpers
def development?
  ENV["RACK_ENV"] == "development"
end

# config
if development?
  worker_processes 1
else
  worker_processes 4
end

timeout 30

