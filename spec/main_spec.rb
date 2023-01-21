require './lib/main.rb'

RSpec.describe FacebookParser do
	before(:each) do
    @test = FacebookParser.new
  end

	after(:each) do
		Capybara.current_session.driver.quit
	end
	
	context "setting user's params" do
		it "should set user's login and password" do
			@test.set_user('john','1234')
			expect(@test.login).to eq 'john'
			expect(@test.password).to eq '1234'
		end

		it "should not be blank" do
			expect{@test.set_user()}.to raise_error(ArgumentError)
		end

		it "should have two arguments" do
			expect{@test.set_user('fafa')}.to raise_error(ArgumentError)
		end
	end

	context "logging in" do
		it "should log in" do
			@test.set_user('debikartur@proton.me', 'debik322')
			@test.log_in
			expect(@test.page).to have_content("Artur Debik")
		end

		it "with wrong data" do
			@test.set_user('bob', 'abo')
			@test.log_in
			expect(@test.page).to have_link('Find your account and log in.')
		end
	end
		
	context "returning friends list" do
		it "shold return friends list" do
			@test.set_user('abobchyk@gmail.com', 'aboba322')
			@test.log_in
			expect(@test.get_friends).to include "Chan Jock Chan"
		end

		it "shold return empty list" do
			@test.set_user('debikartur@proton.me', 'debik322')
			@test.log_in
			expect(@test.get_friends).to be_empty
		end
	end
end