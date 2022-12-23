require './main.rb'

parser = FacebookParser.new
parser.set_user('abobchyk@gmail.com', 'aboba322')
parser.login
parser.get_friends
parser.print_friends