class Property < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  accepts_nested_attributes_for :address

  # criar campos de enum

  before_save :geocode_address

  def geocode_address
    if address&.full_address.present? && address.coordinates.blank?
      address.set_coordinates
    end
  end
end
