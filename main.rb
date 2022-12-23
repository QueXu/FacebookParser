require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'

class FacebookParser

  Capybara.register_driver :chrome do |app|  
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.javascript_driver = :chrome
  Capybara.configure do |config|  
    config.default_max_wait_time = 10
    config.default_driver = :selenium
  end

  def set_user(login, password)
    @login = login
    @password = password
  end

  def login
    @browser = Capybara.current_session
    @driver = @browser.driver.browser
    @browser.visit "https://www.facebook.com"
    @browser.find(:xpath, '//*[@id="email"]').send_keys(@login)
    @browser.find(:xpath, '//*[@id="pass"]').send_keys(@password)
    @browser.find(:xpath, '/html/body/div[1]/div[1]/div[1]/div/div/div/div[2]/div/div[1]/form/div[2]/button').click
    sleep(2)
  end

  def get_friends
    @browser.find(:xpath, '/html/body/div[1]/div/div[1]/div/div[3]/div[3]/div/div[1]/div/div[1]/div/div/div[1]/div/div/div[2]/span/div/a').click
    sleep(10)
    @browser.find(:xpath, '/html/body/div[1]/div/div[1]/div/div[5]/div/div/div[3]/div/div/div[1]/div[1]/div/div/div[3]/div/div/div/div[1]/div/div/div[1]/div/div/div/div/div/div/a[3]/div[1]').click
    sleep(2)
    @doc = Nokogiri::HTML(@driver.page_source);
    @doc = @doc.xpath('/html/body/div[1]/div/div[1]/div/div[5]/div/div/div[3]/div/div/div[1]/div[1]/div/div/div[4]/div/div/div/div[1]/div/div/div/div/div[3]/div/div[2]/div[1]')
  end

  def print_friends
    @doc.xpath('//a/span').each do |node|
      puts node.text
    end
  end
end