# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Network::Application.config.secret_key_base = '3d3042c4124014ceb17b0906fcaee1b39cfc6f57556968b6c8c811aa356d2fa4c89b718575e0e8063e50f6488db4042d7b0741690dc504a0df291d4e1925a2fe'
