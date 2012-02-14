source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'mysql2'
gem 'jquery-rails'
gem 'unicorn'
gem 'activeadmin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
	gem 'bz-cap-recipes', :git => 'git://github.com/BZLabs/bz_cap_recipes.git'
	gem 'capistrano'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'spork-rails'
  gem 'shoulda-matchers'
end
