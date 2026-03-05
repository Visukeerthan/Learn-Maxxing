class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :set_course, only: %i[ new create ]
  before_action :ensure_instructor!, except: [:show]

  def show
  end

  def edit
  end

  def new
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to course_path(@course), notice: "Lesson added successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to lesson_path(@lesson), notice: "Lesson was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
    
    @lesson.destroy
    
    redirect_to course_path(@course), notice: "Lesson removed successfully.", status: :see_other
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to courses_path, alert: "Lesson not found."
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def ensure_instructor!
    unless current_user.instructor?
      redirect_to root_path, alert: "Access Denied: Instructors only."
    end
  end

  def lesson_params
    params.require(:lesson).permit(:title, :body, :course_id)
  end
end