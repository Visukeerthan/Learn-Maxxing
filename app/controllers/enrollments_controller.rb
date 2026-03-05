class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:course_id])
    
    # Avoid duplicate enrollments
    if current_user.enrolled_courses.include?(@course)
      redirect_to @course, alert: "You are already enrolled."
    else
      @enrollment = current_user.enrollments.build(course: @course)
      if @enrollment.save
        redirect_to @course, notice: "Successfully enrolled in #{@course.title}!"
      else
        redirect_to @course, alert: "Enrollment failed."
      end
    end
  end
end