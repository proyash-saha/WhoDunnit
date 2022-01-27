#-----------------------------------------------------------------------------------------
#  CLASS         : AbstractClass
#
#  AUTHOR        : Proyash Saha
#
#  REMARKS       : This is an abstract class (super class) that binds together
#                  all the players (sub class) and avoids code repetition.
#
#-----------------------------------------------------------------------------------------

class AbstractClass

  attr_reader :outOfGame

  def AbstractClass.new(*args)
    if self == AbstractClass
      raise "Don't do this !"
    else
      super
    end
  end

  def initialize
    @outOfGame = false
    @cardList = Array.new
    @numOfPlayers = nil
    @playerIndex = nil
    @suspectList = nil
    @locationList = nil
    @weaponsList = nil
  end

  def setup(numOfPlayers, playerIndex, suspectList, locationList, weaponsList)
    @numOfPlayers = numOfPlayers
    @playerIndex = playerIndex
    @suspectList = suspectList
    @locationList = locationList
    @weaponsList = weaponsList
  end

  def setCard (card)
    @cardList << card
  end

  def canAnswer(playerIndex, guess)
    result = nil
    @cardList.each do |x|
      if x.value == guess.person.value || x.value == guess.place.value || x.value == guess.weapon.value
        result = x
        break
      end
    end
  result
  end

  def getGuess
    suspect = nil
    location = nil
    weapon = nil
    x = 0
    y = 0
    z = 0

    @suspectList.each do |a|
      if not @cardList.include? a
        suspect = a
      else
        x += 1
      end
    end

    @locationList.each do |b|
      if not @cardList.include? b
        location = b
      else
        y += 1
      end
    end

    @weaponsList.each do |c|
      if not @cardList.include? c
        weapon = c
      else
        z += 1
      end
    end

    if @suspectList.size == x+1 && @locationList.size == y+1 && @weaponsList.size == z+1
      guess = Guess.new(suspect, location, weapon, true)
    else
      guess = Guess.new(suspect, location, weapon, false)
    end

    guess
  end

  def receiveInfo(playerIndex, card)
    if not(playerIndex == -1) && not(card == nil)
      @cardList << card
    end
  end

  def remove
    @outOfGame = true
  end

end
