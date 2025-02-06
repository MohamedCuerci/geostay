class Address < ApplicationRecord
  geocoded_by :full_address

  after_validation :geocode, if: ->(obj) { obj.full_address.present? && obj.coordinates.blank? }

  def full_address
    [ street, number, neighborhood, city, state, country ].compact.join(", ")
  end
end
