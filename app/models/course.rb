class Course < ApplicationRecord
  belongs_to :user
  
  # CRITICAL FIX: Add dependent: :destroy to these two lines
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  
  has_many :students, through: :enrollments, source: :user

  validates :title, presence: true
  validates :description, presence: true
end