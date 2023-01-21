require 'selenium-webdriver'
require 'capybara'
require 'headless'

class FacebookParser

  headless = Headless.new
  headless.start

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
    @page.visit 'https://www.facebook.com/friends/list'
    sleep unless @page.has_content?("All friends")
    @page.find_all('div[aria-label="All friends"]').first.find_all('a').map(&:text).slice(2..) 
    # we need .slice(2..) because it has some additional links in that <div>
  end
end