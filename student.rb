class Student
  attr_accessor :average, :final_grade
  attr_reader :name, :grades

  def initialize(name, grades)
    @name = name
    @grades = grades
  end
end
