namespace :development do
  desc "start the development server (http://localhost:3000) and mailcatcher (http://localhost:1080)"
  task :server do
    system "./bin/foreman start -f Procfile.development"
  end
end
