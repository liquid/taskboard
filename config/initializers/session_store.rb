# Be sure to restart your server when you modify this file.

Taskboardapp::Application.config.session_store :active_record_store,
  :key => '_taskboard_session',
  :secret => '3e5780da30892c424c7fb051c8cd8bc97cdb312c00b0cfb8a476c8958d1fdbcd201859f92eb2716487d0ab1665e0a56f002de854d38cc121e849480bb49d95c8'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Taskboard::Application.config.session_store :active_record_store
