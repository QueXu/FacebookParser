require_relative './main.rb'

parser = FacebookParser.new
parser.set_user('abobchyk@gmail.com', 'aboba322')
parser.log_in
parser.get_friends