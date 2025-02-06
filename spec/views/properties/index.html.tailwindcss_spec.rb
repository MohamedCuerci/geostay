require 'rails_helper'

RSpec.describe "properties/index", type: :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        user: nil,
        title: "Title",
        description: "MyText",
        price: "9.99",
        bedrooms: 2,
        bathrooms: 3,
        area: 4,
        status: 5
      ),
      Property.create!(
        user: nil,
        title: "Title",
        description: "MyText",
        price: "9.99",
        bedrooms: 2,
        bathrooms: 3,
        area: 4,
        status: 5
      )
    ])
  end

  it "renders a list of properties" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
  end
end
