require 'rails_helper'

RSpec.describe "courses/edit", type: :view do
  let(:course) {
    Course.create!(
      title: "MyString",
      description: "MyText",
      capacity: 1,
      price_cents: 1,
      published: false,
      instructor: nil
    )
  }

  before(:each) do
    assign(:course, course)
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(course), "post" do

      assert_select "input[name=?]", "course[title]"

      assert_select "textarea[name=?]", "course[description]"

      assert_select "input[name=?]", "course[capacity]"

      assert_select "input[name=?]", "course[price_cents]"

      assert_select "input[name=?]", "course[published]"

      assert_select "input[name=?]", "course[instructor_id]"
    end
  end
end
