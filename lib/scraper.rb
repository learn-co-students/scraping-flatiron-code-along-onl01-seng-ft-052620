require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page
    Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
  end

  def get_courses
    get_page.css(".posts-holder")
  end


  def make_courses
    
    info= get_courses.children.map {|child|
    [title = child.css('h2').text,
    schedule =  child.css('.date').text,
    description = child.css('p').text]
  }

  filtered_info = info.select{|item| item[0] !=""}
  filtered_info.each{|item| 
a=Course.new
a.title =item[0]
a.schedule = item[1]
a.description= item[2]}
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



