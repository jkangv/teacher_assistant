require 'csv'
require_relative 'grade_reader'
require_relative 'student'

class GradeSummary
  attr_accessor :students

  def initialize(data)
    @students = []
    data.grades.each do |name, scores|
      student = Student.new(name, scores)
      student.average = scores.inject(0.0) {|sum, grade| sum + grade.to_i} / scores.size
      student.final_grade = case
      when student.average >= 90.0
        "A"
      when student.average >= 80.0 && student.average < 90.0
        "B"
      when student.average >= 70.0 && student.average < 80.0
        "C"
      when student.average >= 60.0 && student.average < 70.0
        "D"
      when student.average < 60.0
        "F"
      end
      @students << student
    end
  end

  def report
    report = []
    @students.each do |student|
      grades = student.grades.join(',')
      report << "#{student.name}: #{grades}"
    end
    report
  end

  def averages
    averages = []
    @students.each do |student|
      averages << "#{student.name}: #{student.average}"
    end
    averages
  end

  def final_grades
    final_grades = []
    @students.each do |student|
      final_grades << "#{student.name}: #{student.final_grade}"
    end
    final_grades
  end

  def report_grades
    report = ""
    @students.each do |student|
      report += "#{student.name}: #{student.average} / #{student.final_grade}\n"
    end
    File.open("report_card.csv", "a") do |f|
      f.write(report)
    end
  end

  def report_class_data
    all_averages = []
    @students.each {|student| all_averages << student.average}
    puts "Average of the class: #{all_averages.inject(0.0) {|sum, average| sum + average}/all_averages.size}"
    puts "Minimum score: #{all_averages.min}"
    print "Maximum score: #{all_averages.max}"
  end
end

data = GradeReader.new("grades.csv")
summary = GradeSummary.new(data)
puts summary.report
puts summary.averages
puts summary.final_grades
summary.report_grades
puts summary.report_class_data
