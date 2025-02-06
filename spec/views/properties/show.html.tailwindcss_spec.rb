require 'rails_helper'

RSpec.describe "properties/show", type: :view do
  before(:each) do
    assign(:property, Property.create!(
      user: nil,
      title: "Title",
      description: "MyText",
      price: "9.99",
      bedrooms: 2,
      bathrooms: 3,
      area: 4,
      status: 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
