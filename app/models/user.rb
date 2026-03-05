class User < ApplicationRecord
  # Devise modules (keep these)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # --- THE FIX ---
  # This allows you to call current_user.courses
  has_many :courses, dependent: :destroy
  
  # This allows you to call current_user.enrolled_courses
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course

  enum :role, { student: 0, instructor: 1 }, default: 0
end