require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
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

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    page = self.get_page
    page.css("section.posts-holder article.post")
  end

  
  def make_courses
    self.get_courses.each do |course_data|
      course = Course.new
      course.title = course_data.css("h2").text
      course.schedule = course_data.css("em.date").text
      course.description = course_data.css("p").text
    end
  end
  
end

Scraper.new.print_courses