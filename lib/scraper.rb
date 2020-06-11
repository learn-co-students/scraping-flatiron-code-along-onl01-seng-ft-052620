require 'nokogiri'
require 'open-uri'

require_relative './course.rb'
require "pry"
class Scraper
  attr_accessor :doc
  def get_page
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/site-for-scraping/courses"))
    # doc.css(".post").each do |post|
    #   course = Course.new
    #   course.title = post.css("h2").text
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end
    # binding.pry
  end

  def get_courses
    get_page.css("#course-grid .post")
   
  end

  def make_courses
   
    get_courses.each do |post|
      course = Course.new
       course.title = post.css("h2").text # returns the title
       course.schedule = post.css("em").text
      course.description = post.css("p").text
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



