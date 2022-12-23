require './main.rb'


RSpec.describe 'FacebookParser testing' do
  describe "set_user method" do
    it "should set login and password" do
			test = FacebookParser.new
      test.set_user('john','1234').should(@login == 'john' && @password == '1234')
    end
	end  
end