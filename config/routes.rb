Rails.application.routes.draw do
  # 1. MANUAL LOGOUT FIX
  # This ensures the 'Sign Out' button works even if JavaScript/Turbo glitches
  devise_scope :user do
    delete '/logout', to: 'sessions#destroy', as: :logout
  end

  # 2. AUTHENTICATION
  devise_for :users

  # 3. CORE FEATURES (NESTED RESOURCES)
  # This creates helpers like course_lesson_path(@course, @lesson)
  resources :courses do
    resources :lessons
  end

  # 4. ENROLLMENT SYSTEM
  # Only need 'create' to link a student to a course
  resources :enrollments, only: [:create]

  # 5. HEALTH CHECK & PWA (Standard Rails 8)
  get "up" => "rails/health#show", as: :rails_health_check

  # 6. ROOT PATH
  # This is the 'Learn Maxxing' landing page
  root "home#index"
end