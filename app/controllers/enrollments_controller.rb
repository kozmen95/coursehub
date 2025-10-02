class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_enrollment, only: [:update, :destroy]

  # GET /courses/:course_id/enrollments
  # Podgląd zapisów — tylko instruktor kursu lub admin
  def index
    authorize @course, :manage_enrollments?
    @enrollments = @course.enrollments.includes(:user).order(created_at: :desc)
  end

  # POST /courses/:course_id/enrollments
  def create
    @enrollment = @course.enrollments.find_or_initialize_by(user: current_user)
    authorize @enrollment # EnrollmentPolicy#create?

    if @enrollment.persisted?
      redirect_to @course, notice: "Jesteś już zapisany na ten kurs."
    else
      @enrollment.status = :pending
      if @enrollment.save
        redirect_to @course, notice: "Zgłosiłeś się na kurs ✅ (oczekuje na potwierdzenie)."
      else
        redirect_to @course, alert: @enrollment.errors.full_messages.to_sentence
      end
    end
  end

  # PATCH /courses/:course_id/enrollments/:id
  # Instruktor kursu lub admin zmienia status (confirmed / rejected / pending)
  def update
    authorize @enrollment

    new_status = params[:status].to_s.presence_in(Enrollment.statuses.keys)
    if new_status && @enrollment.update(status: new_status)
      redirect_to @course, notice: "Status zapisu został zmieniony ✅"
    else
      redirect_to @course, alert: "Nieprawidłowy status."
    end
  end

  # DELETE /courses/:course_id/enrollments/:id
  # Wypisać się może właściciel zapisu albo admin
  def destroy
    authorize @enrollment # EnrollmentPolicy#destroy?

    msg = if current_user == @enrollment.user
      "Wypisałeś się z kursu ❌"
    else
      "Użytkownik został wypisany z kursu ❌"
    end

    @enrollment.destroy
    redirect_to @course, notice: msg
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_enrollment
    @enrollment = @course.enrollments.find(params[:id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:status)
  end
end
