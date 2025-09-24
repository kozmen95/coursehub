require 'rails_helper'

RSpec.describe "lessons/edit", type: :view do
  let(:lesson) {
    Lesson.create!(
      course: nil,
      location: "MyString"
    )
  }

  before(:each) do
    assign(:lesson, lesson)
  end

  it "renders the edit lesson form" do
    render

    assert_select "form[action=?][method=?]", lesson_path(lesson), "post" do

      assert_select "input[name=?]", "lesson[course_id]"

      assert_select "input[name=?]", "lesson[location]"
    end
  end
end
