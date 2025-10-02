require "rails_helper"

RSpec.describe Course, type: :model do
  let(:instructor) { User.create!(email: "instr@test.com", password: "password", role: :instructor) }

  it "is valid with valid attributes" do
    course = Course.new(title: "Ruby 101", description: "Basics", capacity: 10, price_cents: 1000, instructor: instructor)
    expect(course).to be_valid
  end

  it "is invalid without a title" do
    course = Course.new(title: nil, instructor: instructor, capacity: 10, price_cents: 1000)
    expect(course).not_to be_valid
  end

  it "is invalid with non-positive capacity" do
    course = Course.new(title: "Test", instructor: instructor, capacity: 0, price_cents: 1000)
    expect(course).not_to be_valid
  end
end
