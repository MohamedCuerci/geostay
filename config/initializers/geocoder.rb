Geocoder.configure(
  lookup: :google,
  api_key: Rails.application.credentials.google["api_key"],
  units: :km,
  timeout: 5
)
