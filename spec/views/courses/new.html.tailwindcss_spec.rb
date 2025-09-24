require 'rails_helper'

RSpec.describe "courses/new", type: :view do
  before(:each) do
    assign(:course, Course.new(
      title: "MyString",
      description: "MyText",
      capacity: 1,
      price_cents: 1,
      published: false,
      instructor: nil
    ))
  end

  it "renders new course form" do
    render

    assert_select "form[action=?][method=?]", courses_path, "post" do

      assert_select "input[name=?]", "course[title]"

      assert_select "textarea[name=?]", "course[description]"

      assert_select "input[name=?]", "course[capacity]"

      assert_select "input[name=?]", "course[price_cents]"

      assert_select "input[name=?]", "course[published]"

      assert_select "input[name=?]", "course[instructor_id]"
    end
  end
end
