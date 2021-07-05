require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    #calls on .make_courses & iterates over all courses & puts out a list of course offerings
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    #responsible for using Nokogiri & open-uri to grab entire HTML doc from webpage
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))


    # binding.pry
  end

  def get_courses
    self.get_page.css(".post")
    #responsible for using a CSS selector to grab HTML elements that contain a course
    #return value should be an array of Nokogiri XML elements, each describing the course offering
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
    #responsible for instantiating Course objects & giving each the correct title, schedule & description
  end
  
end

Scraper.new.print_courses

