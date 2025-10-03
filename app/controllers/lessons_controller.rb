class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]


  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  # GET /courses/:course_id/lessons
  def index
    @lessons = policy_scope(@course.lessons).order(starts_at: :asc)
  end

  # GET /courses/:course_id/lessons/:id
  def show
    authorize @lesson
  end

  # GET /courses/:course_id/lessons/new
  def new
    @lesson = @course.lessons.new
    authorize @lesson
  end

  # GET /courses/:course_id/lessons/:id/edit
  def edit
    authorize @lesson
  end

  # POST /courses/:course_id/lessons
  def create
    @lesson = @course.lessons.new(lesson_params)
    authorize @lesson

    if @lesson.save
      redirect_to [@course, @lesson], notice: "Lekcja dodana ✅"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/:course_id/lessons/:id
  def update
    authorize @lesson
    if @lesson.update(lesson_params)
      redirect_to [@course, @lesson], notice: "Lekcja zaktualizowana ✅"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:course_id/lessons/:id
  def destroy
    authorize @lesson
    @lesson.destroy
    redirect_to course_lessons_path(@course), notice: "Lekcja usunięta ✅"
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :date, :starts_at, :ends_at, :location, materials: [])
  end
end
