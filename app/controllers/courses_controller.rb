# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.order(created_at: :desc)
  end

  # GET /courses/:id
  def show
    # publiczny podgląd kursu
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/:id/edit
  def edit
    authorize @course
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.instructor = current_user
    authorize @course

    if @course.save
      redirect_to @course, notice: "Kurs został utworzony ✅"
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
    params.require(:course).permit(:title, :description, :capacity, :price_cents, :published, :cover_image)
  end
end
