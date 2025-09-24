class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authorize_manage!, only: [:new, :create, :edit, :update, :destroy]

  # GET /courses/:course_id/lessons
  def index
    # każdy zalogowany może podglądać; ewentualnie ogranicz do zapisanych
    @lessons = @course.lessons.order(starts_at: :asc)
  end

  # GET /courses/:course_id/lessons/:id
  def show; end

  # GET /courses/:course_id/lessons/new
  def new
    @lesson = @course.lessons.new
  end

  # GET /courses/:course_id/lessons/:id/edit
  def edit; end

  # POST /courses/:course_id/lessons
  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to [@course, @lesson], notice: "Lekcja dodana ✅"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/:course_id/lessons/:id
  def update
    if @lesson.update(lesson_params)
      redirect_to [@course, @lesson], notice: "Lekcja zaktualizowana ✅"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:course_id/lessons/:id
  def destroy
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
    params.require(:lesson).permit(:starts_at, :ends_at, :location, materials: [])
  end

  # tylko instruktor kursu lub admin mogą modyfikować lekcje
  def authorize_manage!
    unless current_user == @course.instructor || current_user&.admin?
      redirect_to course_lessons_path(@course), alert: "Brak uprawnień do zarządzania lekcjami."
    end
  end
end
