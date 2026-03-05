puts "Cleaning database..."
Enrollment.destroy_all
Lesson.destroy_all
Course.destroy_all
User.destroy_all

puts "Creating Users..."
# Create a Trainer
trainer = User.create!(
  email: "trainer@maxxing.com",
  password: "password123",
  role: :instructor
)

# Create a Student
student = User.create!(
  email: "student@maxxing.com",
  password: "password123",
  role: :student
)

puts "Creating Course..."
course = Course.create!(
  title: "Ruby on Rails Mastery",
  description: "Learn to build professional EdTech platforms from scratch.",
  user: trainer
)

puts "Creating Lessons..."
course.lessons.create!([
  { title: "Introduction to MVC", body: "The Model-View-Controller pattern is the heart of Rails..." },
  { title: "Mastering Migrations", body: "Learn how to manage your MySQL database schema effectively." },
  { title: "Authentication with Devise", body: "Secure your app with industry-standard login systems." }
])

puts "Seeding complete!"
puts "Login as Trainer: trainer@maxxing.com / password123"
puts "Login as Student: student@maxxing.com / password123"