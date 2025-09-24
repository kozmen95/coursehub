require 'rails_helper'

RSpec.describe "enrollments/index", type: :view do
  before(:each) do
    assign(:enrollments, [
      Enrollment.create!(
        user: nil,
        course: nil,
        status: 2,
        note: "MyText"
      ),
      Enrollment.create!(
        user: nil,
        course: nil,
        status: 2,
        note: "MyText"
      )
    ])
  end

  it "renders a list of enrollments" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
