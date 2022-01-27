#-----------------------------------------------------------------------------------------
#  CLASS         : Guess
#
#  AUTHOR        : Proyash Saha
#
#  REMARKS       : This class is used to create a new Guess that a player
#                           makes in the game.
#
#-----------------------------------------------------------------------------------------

class Guess

  attr_reader :person, :place, :weapon, :type

  def initialize(person, place, weapon, type)
    @person = person
    @place = place
    @weapon = weapon
    @type = type
  end

  def isAccusation
    result = false
    if type
      result = true
    end
    result
  end

end
