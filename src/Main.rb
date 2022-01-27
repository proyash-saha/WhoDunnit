#-----------------------------------------------------------------------------------------
#  CLASS            : Main
#
#  AUTHOR         : Proyash Saha
#
#  REMARKS       : Main class(entry point) for the game.
#
#-----------------------------------------------------------------------------------------

require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "Model"
require_relative "InteractivePlayer"

puts("\n--- Welcome to \"whodunnit?\" ---\n")

people = [ 
  Card.new(:person,"John"), 
  Card.new(:person,"Mary"),
  Card.new(:person,"Joseph"),
  Card.new(:person,"Liara"),
  Card.new(:person,"Higgins"),
  Card.new(:person,"Yun"), 
  Card.new(:person,"Andre"), 
  Card.new(:person,"Mike"), 
  Card.new(:person,"Andrea") 
]

places = [ 
  Card.new(:place,"Lagos"),
  Card.new(:place,"Los Angeles"),
  Card.new(:place,"Delhi"),
  Card.new(:place,"Amsterdam"),
  Card.new(:place,"Tokyo")
]

weapons = [ 
  Card.new(:weapon,"Knife"),
  Card.new(:weapon,"Gun"),
  Card.new(:weapon,"Poison"),
  Card.new(:weapon,"Bow and Arrow"),
]

game = Model.new(people, places, weapons)
puts("\nHow many computer opponents would you like?")
numPlayers = gets.chomp.to_i

players = Array.new(numPlayers+1)
(numPlayers).times { |i| players[i] = Player.new() }
players[numPlayers] = InteractivePlayer.new()

sleep(2)
puts("\nSetting up players..")
sleep(2)
game.setPlayers(players)

sleep(2)
puts("\nDealing cards..")
sleep(2)
game.setupCards()

sleep(2)
puts("\nPlaying...")
sleep(2)
game.play()

sleep(2)
puts ("\nGame over")
