require 'rails_helper'

RSpec.describe "lessons/show", type: :view do
  before(:each) do
    assign(:lesson, Lesson.create!(
      course: nil,
      location: "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Location/)
  end
end
