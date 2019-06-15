require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_index_array = []

    doc.css(".student-card").each do |student|
      student_index_array << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      binding.pry
    end
    student_index_array
  end

    def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)


    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end

    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text
    doc.css(".main-wrapper div.social-icon-container").each do |link|
    array <<  link.css("a").attribute("href").value

    student_profile
  end
end
end

=begin

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html) 
    
    student_hash = {}
    

doc.css(".main-wrapper").each do |link|
student_hash = {
  :twitter => link.css("div.social-icon-container a:nth-of-type(1)").attribute("href").value,
  :linkedin => link.css("div.social-icon-container a:nth-of-type(2)").attribute("href").value,
  :github => link.css("div.social-icon-container a:nth-of-type(3)").attribute("href").value,
  :blog => link.css("div.social-icon-container a:nth-of-type(4)").attribute("href").value,
  :profile_quote => link.css(".vitals-text-container div.profile-quote").text,
  :bio => link.css(".details-container p").text
}
end
#    binding.pry

student_hash  

  end

=end