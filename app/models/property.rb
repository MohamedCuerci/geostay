class Property < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  delegate :coordinates, to: :address
  has_many_attached :photos, dependent: :destroy

  accepts_nested_attributes_for :address

  before_save :geocode_address

  validates :title, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_details,
  against: :title,
  associated_against: {
    address: [ :street, :neighborhood, :city, :state ]
  },
  using: {
    tsearch: { prefix: true }
  }

  scope :by_bedrooms, ->(bedrooms_number) { where(bedrooms: bedrooms_number) if bedrooms_number.present? }
  scope :by_bathrooms, ->(bathrooms_number) { where(bathrooms: bathrooms_number) if bathrooms_number.present? }
  scope :by_status, ->(status) { where(status: status) if status.present? }

  enum :status, {
    sell: 0, # vender
    rent: 1, # alugar
    season: 2 # temporada (like airbnb)
  }

  def geocode_address
    if address&.full_address.present? && address.coordinates.blank?
      address.set_coordinates
    end
  end
end
