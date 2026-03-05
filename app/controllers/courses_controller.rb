class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # Only allow instructors to touch these specific actions
  before_action :ensure_instructor!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
    # @course is set by before_action
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to @course, notice: "Course successfully maxxed!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path, notice: "Course was successfully deleted.", status: :see_other
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def ensure_instructor!
    unless current_user.instructor?
      redirect_to root_path, alert: "Access denied. Only Trainers can manage courses."
    end
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end
end