json.extract! lesson, :id, :title, :body, :course_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
