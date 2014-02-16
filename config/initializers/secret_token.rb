# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

#Puru1SampleApp::Application.config.secret_key_base = '088dff2c15b721a9928ec360b991efc63cfa9f42fde9a9c434a46488ddc8bfb7f09bee438c8ed28d56e6cbbb20175d4edb08dc37eb40b8ddb79f48e9abe30639'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Puru1SampleApp::Application.config.secret_key_base = secure_token