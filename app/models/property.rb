class Property < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  delegate :coordinates, to: :address
  has_many_attached :photos, dependent: :destroy

  accepts_nested_attributes_for :address

  enum :status, {
    sell: 0, # vender
    rent: 1, # alugar
    season: 2 # temporada (like airbnb)
  }

  before_save :geocode_address

  def geocode_address
    if address&.full_address.present? && address.coordinates.blank?
      address.set_coordinates
    end
  end
end
