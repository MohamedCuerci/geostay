module PropertiesHelper
  def part_address(address)
    [ address.street, address.neighborhood, address.city ].compact.join(", ")
  end
end
