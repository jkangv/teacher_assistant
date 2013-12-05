class GradeReader
  attr_reader :list 

  def initialize(filename)
    raise "#{filename} does not exist" unless File.exists?(filename)
    @filename = filename
  end

  def parse
    grades_file = IO.read(@filename)
    grades_file = CSV.parse("#{grades_file}")
    grades_file
  end

  def students
    students = []
    parse.each {|info| students << info[0]}
    students
  end

  def grades
    grades = {}
    parse.each do |info|
      grades[info[0]] = info[1..-1]
    end
    grades
  end
end
