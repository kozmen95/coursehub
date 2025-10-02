# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  skip_after_action :verify_authorized, only: :index
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  def index
    @courses = policy_scope(Course)
  end

  
  # GET /courses/:id
  def show
    authorize @course
  end

  def new
    @course = current_user.taught_courses.build
    authorize @course
  end

  # GET /courses/:id/edit
  def edit
    authorize @course
  end

    # POST /courses
  def create
    @course = current_user.taught_courses.build(course_params)
    authorize @course
    if @course.save
      redirect_to @course, notice: "Kurs utworzony ✅"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/:id
  def update
    authorize @course
    if @course.update(course_params)
      redirect_to @course, notice: "Kurs został zaktualizowany ✅"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:id
  def destroy
    authorize @course
    @course.destroy
    redirect_to courses_url, notice: "Kurs został usunięty ✅"
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  # dopasuj do swoich kolumn w tabeli courses
  def course_params
    params.require(:course).permit(
      :title, :description, :capacity, :price_cents, :published, :cover_image,
      lessons_attributes: [:id, :title, :date, :location, :_destroy]
    )
  end
end
