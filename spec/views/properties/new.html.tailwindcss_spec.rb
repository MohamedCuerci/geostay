require 'rails_helper'

RSpec.describe "properties/new", type: :view do
  before(:each) do
    assign(:property, Property.new(
      user: nil,
      title: "MyString",
      description: "MyText",
      price: "9.99",
      bedrooms: 1,
      bathrooms: 1,
      area: 1,
      status: 1
    ))
  end

  it "renders new property form" do
    render

    assert_select "form[action=?][method=?]", properties_path, "post" do

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
