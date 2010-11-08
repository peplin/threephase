# This is how your config file should look.
# This is my Heroku config file.
# Heroku recommends setting environment variables on their system

case Rails.env
when "development"
  AuthlogicConnect.config = YAML.load_file("config/authlogic.yml")
when "production"
  AuthlogicConnect.config = YAML.load_file("config/authlogic.yml")
end
