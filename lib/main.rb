require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require 'pry'

class FacebookParser

  Capybara.register_driver :chrome do |app|  
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.javascript_driver = :chrome
  Capybara.configure do |config|  
    config.default_max_wait_time = 10
    config.default_driver = :selenium
  end

  attr_reader :login, :password, :page, :driver

  def set_user(login, password)
    @login = login
    @password = password
  end

  def log_in
    @page = Capybara.current_session
    @driver = @page.driver.browser
    @page.visit 'https://www.facebook.com'
    @page.find_field('Email or phone number').send_keys(@login)
    @page.find_field('Password').send_keys(@password)
    @page.find_button('Log In').click
  end

  def get_friends
    result = []
    @page.visit 'https://www.facebook.com/friends/list'
    sleep unless @page.has_content?("Select people's names to preview their profile.")
    doc = Nokogiri::HTML(@driver.page_source)
    content = doc.css("span.x193iq5w.xeuugli.x13faqbe.x1vvkbs.x10flsy6.x6prxxf.xvq8zen.x1s688f.xzsf02u")

    content.each do |node|
      result << node.text   
    end
    result  
  end
end