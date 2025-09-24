# app/controllers/enrollments_controller.rb
class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_enrollment, only: [:update, :destroy]

  # GET /courses/:course_id/enrollments
  # Podgląd zapisów — tylko instruktor kursu lub admin
  def index
    authorize @course, :update? # w CoursePolicy update? = instructor kursu lub admin
    @enrollments = @course.enrollments.includes(:user).order(created_at: :desc)
  end

  # POST /courses/:course_id/enrollments
  # Student dołącza do kursu (status: pending)
  def create
    @enrollment = @course.enrollments.find_or_initialize_by(user: current_user)
    authorize @enrollment # EnrollmentPolicy#create? => user.student?

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
  # Instruktor kursu lub admin zmienia status (confirmed / cancelled / pending)
  def update
    authorize @enrollment # EnrollmentPolicy#update? => instructor kursu lub admin

    new_status = params[:status].to_s.presence_in(Enrollment.statuses.keys)
    return redirect_to(@course, alert: "Nieprawidłowy status.") unless new_status

    if @enrollment.update(status: new_status)
      redirect_to @course, notice: "Status zapisu został zmieniony ✅"
    else
      redirect_to @course, alert: @enrollment.errors.full_messages.to_sentence
    end
  end

  # DELETE /courses/:course_id/enrollments/:id
  # Wypisać się może właściciel zapisu albo admin
  def destroy
    authorize @enrollment # EnrollmentPolicy#destroy? => record.user == user lub admin
    @enrollment.destroy
    redirect_to @course, notice: "Wypisałeś się z kursu ❌"
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_enrollment
    @enrollment = @course.enrollments.find(params[:id])
  end
end
