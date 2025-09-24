class CoursePolicy < ApplicationPolicy
  def index?  = true
  def show?   = true

  def new?     = create?
  def create?  = user&.instructor? || user&.admin?
  def edit?    = update?
  def update?  = record.instructor == user || user&.admin?
  def destroy? = record.instructor == user || user&.admin?
end