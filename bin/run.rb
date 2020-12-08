require_relative '../config/environment'
require_relative '../bin/cli.rb'

#puts "HELLO WORLD"

cli = CLI.new
cli.main_menu()
# cli.switch_song
# cli.play_music('/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/Mario-coin-sound.mp3')