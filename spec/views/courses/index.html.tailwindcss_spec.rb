require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        title: "Title",
        description: "MyText",
        capacity: 2,
        price_cents: 3,
        published: false,
        instructor: nil
      ),
      Course.create!(
        title: "Title",
        description: "MyText",
        capacity: 2,
        price_cents: 3,
        published: false,
        instructor: nil
      )
    ])
  end

  it "renders a list of courses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
