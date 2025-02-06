require 'rails_helper'

RSpec.describe "properties/edit", type: :view do
  let(:property) {
    Property.create!(
      user: nil,
      title: "MyString",
      description: "MyText",
      price: "9.99",
      bedrooms: 1,
      bathrooms: 1,
      area: 1,
      status: 1
    )
  }

  before(:each) do
    assign(:property, property)
  end

  it "renders the edit property form" do
    render

    assert_select "form[action=?][method=?]", property_path(property), "post" do

      assert_select "input[name=?]", "property[user_id]"

      assert_select "input[name=?]", "property[title]"

      assert_select "textarea[name=?]", "property[description]"

      assert_select "input[name=?]", "property[price]"

      assert_select "input[name=?]", "property[bedrooms]"

      assert_select "input[name=?]", "property[bathrooms]"

      assert_select "input[name=?]", "property[area]"

      assert_select "input[name=?]", "property[status]"
    end
  end
end
