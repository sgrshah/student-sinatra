require 'sqlite3'
require 'pry'
require 'erb'

class Student

  DB = SQLite3::Database.new( "students.db" )

  ATTRIBUTES = {
    "id" => "INTEGER PRIMARY KEY AUTOINCREMENT",
    "name" => "TEXT",  
    "image_url" => "TEXT",
    "quote" => "TEXT",
    "twitter_url" => "TEXT",
    "linkedin_url" => "TEXT",
    "github_url" => "TEXT",
    "blog_url" => "TEXT",
    "treehouse_url" => "TEXT",
    "codeschool_url" => "TEXT",
    "coderwall_url" => "TEXT"
  }
    # "tagline" => "TEXT",
    # "bio" => "TEXT",

  ATTRIBUTES.each do |key, value|
    attr_accessor key.to_sym
  end

  def self.create_table
    DB.execute("CREATE TABLE student (
      #{ATTRIBUTES.collect {|key, value| 
        key + " " + value
        }.join(",")});") 
  end

  def self.drop
    DB.execute("DROP TABLE IF EXISTS student;")
  end 

  def self.table_exists?(table)
    exists = DB.execute("SELECT name FROM sqlite_master WHERE 
      type='table' AND name='#{table}'
      ;")
  end

  def save
    if @id #already in database
       ATTRIBUTES.each do |key, value|
        DB.execute("UPDATE student SET #{key} = ? WHERE id = ?;", [self.send(key), @id])
      end
    else #if it isn't
       DB.execute("INSERT INTO student(#{ATTRIBUTES.keys[1..-1].join(",")}) VALUES 
         (#{('?,' * (ATTRIBUTES.size - 1))[0..-2]});", 
         ATTRIBUTES.keys[1..-1].collect{|key| self.send(key)}) 
    
      max_id = DB.execute("SELECT max(id) FROM student;")
      @id = max_id.flatten.first
    end
  end

  def self.make_student_from_record(record)
    student = Student.new.tap do |s|
      ATTRIBUTES.keys.each_with_index do |key, index| 
        s.send(key + '=', record[index])
      end
    end
  end

  def self.find_by_name(name)
    record = DB.execute("SELECT * FROM student WHERE name = '#{name}';").first
    make_student_from_record(record)
  end

  def self.find_by_bio(bio)
    record = DB.execute("SELECT * FROM student WHERE bio = '#{bio}';").first
    make_student_from_record(record)
  end

  def self.find_by_tagline(tagline)
    record = DB.execute("SELECT * FROM student WHERE tagline = '#{tagline}';").first
    make_student_from_record(record)
  end

  def self.all
    DB.execute("SELECT * FROM student;").collect{|record| make_student_from_record(record)}
  end

  def self.find(finder_id)
    record = DB.execute("SELECT * FROM student WHERE id = #{finder_id};").first
    make_student_from_record(record)
  end

  def self.where(query)
    records = DB.execute("SELECT * FROM student WHERE name = '#{query[:name]}';")
    records.collect{|record| make_student_from_record(record)}
  end

  def get_binding
    biding
  end

end





