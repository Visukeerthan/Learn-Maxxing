class Enrollment < ApplicationRecord
  # These are the connections to the other tables
  belongs_to :user
  belongs_to :course

  # This prevents a student from enrolling twice in the same course
  validates :user_id, uniqueness: { scope: :course_id, message: "is already enrolled in this course" }
end