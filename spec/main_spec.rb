require './lib/main.rb'

RSpec.describe FacebookParser do
	before(:each) do
    @test = FacebookParser.new
  end
	
	context "setting user's params" do
		it "should set user's login and password" do
			@test.set_user('john','1234').should(@login == 'john' && @password == '1234')
		end

		it "should not be blank" do
			expect{@test.set_user()}.to raise_error(ArgumentError)
		end

		it "should have two arguments" do
			expect{@test.set_user('fafa')}.to raise_error(ArgumentError)
		end
	end
		
	context "returning friends list" do
		it "shold return friends list" do
			@test.set_user('abobchyk@gmail.com', 'aboba322')
			@test.login
			expect(@test.get_friends).not_to be_empty
			expect(@test.get_friends).to include("Kate Noone")
		end
	end
end