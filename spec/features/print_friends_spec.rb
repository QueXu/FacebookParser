require './main.rb'


RSpec.describe 'FacebookParser testing' do
  describe "print_driends method" do
    it "should output something to console" do
			test = FacebookParser.new
      test.set_user('abobchyk@gmail.com', 'aboba322')
			test.login
			test.get_friends
		  expect { test.print_friends }.to output("\n\n\nНаціональний банк України\n\nСільпо\n\nВіталій Кім - голова Миколаївської ОДА\n\nКомандування Сил підтримки Збройних Сил України\n").to_stdout
    end
	end  
end