class Address < ApplicationRecord
  belongs_to :property

  geocoded_by :full_address

  # dessa forma n funciona, preciso testar com um before_validation ou before_save
  # after_validation :geocode, if: ->(obj) { obj.full_address.present? && obj.coordinates.blank? }

  def full_address
    [ street, number, neighborhood, city, state, country ].compact.join(", ")
  end

  def set_coordinates
    # Rails.logger.info "Geocoding address: #{full_address}"
    results = Geocoder.search(full_address)
    if results.present?
      # Rails.logger.info "Coordinates found: #{results.first.coordinates}"
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
      self.coordinates = factory.point(results.first.longitude, results.first.latitude)
      #  da pra setar o country aqui tb
      # self.country = results.first.country
    else
      Rails.logger.info "No coordinates found for address: #{full_address}"
    end
  end
end
