require 'rails_helper'

RSpec.describe "enrollments/edit", type: :view do
  let(:enrollment) {
    Enrollment.create!(
      user: nil,
      course: nil,
      status: 1,
      note: "MyText"
    )
  }

  before(:each) do
    assign(:enrollment, enrollment)
  end

  it "renders the edit enrollment form" do
    render

    assert_select "form[action=?][method=?]", enrollment_path(enrollment), "post" do

      assert_select "input[name=?]", "enrollment[user_id]"

      assert_select "input[name=?]", "enrollment[course_id]"

      assert_select "input[name=?]", "enrollment[status]"

      assert_select "textarea[name=?]", "enrollment[note]"
    end
  end
end
