require 'rails_helper'

RSpec.describe "enrollments/show", type: :view do
  before(:each) do
    assign(:enrollment, Enrollment.create!(
      user: nil,
      course: nil,
      status: 2,
      note: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
