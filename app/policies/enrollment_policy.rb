class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.student? # student może się zapisywać
  end

  def update?
    user.admin? || (user.instructor? && record.course.instructor == user)
  end

  def destroy?
    user.admin? || record.user == user
  end

  def index?
    update? # tylko instruktor kursu lub admin widzą listę
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
