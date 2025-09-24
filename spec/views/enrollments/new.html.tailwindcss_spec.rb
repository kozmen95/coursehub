require 'rails_helper'

RSpec.describe "enrollments/new", type: :view do
  before(:each) do
    assign(:enrollment, Enrollment.new(
      user: nil,
      course: nil,
      status: 1,
      note: "MyText"
    ))
  end

  it "renders new enrollment form" do
    render

    assert_select "form[action=?][method=?]", enrollments_path, "post" do

      assert_select "input[name=?]", "enrollment[user_id]"

      assert_select "input[name=?]", "enrollment[course_id]"

      assert_select "input[name=?]", "enrollment[status]"

      assert_select "textarea[name=?]", "enrollment[note]"
    end
  end
end
