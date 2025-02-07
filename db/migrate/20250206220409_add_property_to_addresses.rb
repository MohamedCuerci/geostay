class AddPropertyToAddresses < ActiveRecord::Migration[7.2]
  def change
    add_reference :addresses, :property, null: false, foreign_key: true
  end
end
