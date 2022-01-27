#-----------------------------------------------------------------------------------------
#  CLASS            : InteractivePlayer
#
#  AUTHOR         : Proyash Saha, 7833550
#
#  REMARKS       : This is a class that creates human player objects.
#
#-----------------------------------------------------------------------------------------

require_relative "AbstractClass"

class InteractivePlayer < AbstractClass

  def initialize
    super
  end


  def setup(numOfPlayers, playerIndex, suspectList, locationList, weaponsList)
    super
  end


  def setCard(card)
    super
  end


  def canAnswer(playerIndex, guess)
    result = nil
    tempArray = Array.new
    @cardList.each do |x|
      if x.value == guess.person.value || x.value == guess.place.value || x.value == guess.weapon.value
        tempArray << x
        result = tempArray
      end
    end

    # if he cannot refute the guess
    if result == nil
      print "Player #{playerIndex} asked you about Suggestion: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}, but you couldn't answer.\n"
    # if he has only one card and can refute the guess
    elsif result.size == 1
      print "Player #{playerIndex} asked you about Suggestion: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}, you only have one card, #{result[0].value}, showed it to them.\n"
    # if he has more than one card and can refute the guess
    else
      print "Player #{playerIndex} asked you about Suggestion: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}. Which do you show?\n"
    end

    result
  end


  def getGuess
    print "\nIt is your turn.\n"

    print "Which person do you want to suggest?\n"
    person = getCard(@suspectList)                         # getting the guess for person
    print "Which location do you want to suggest?\n"
    location = getCard(@locationList)                      # getting the guess for place
    print "Which weapon do you want to suggest?\n"
    weapon = getCard(@weaponsList)                         # getting the guess for weapon

    print "Is this an accusation (Y/[N])?\n"
    accusation = gets.chomp
    if accusation == "y" || accusation == "Y"              # if guess is an accusation
      type = true
    elsif accusation == "n" || accusation == "N"           # if guess is a suggestion
      type = false
    end

    guess = Guess.new(person,location,weapon,type)
    guess
  end


  def receiveInfo(playerIndex, card)
    if playerIndex != -1 && card != nil
      print "Player #{playerIndex} refuted your suggestion by showing you #{card.value}.\n"
    else
      print "No one could refute your suggestion.\n"
    end
  end


  # method to print all the cards that the human player gets
  def myCardList
    @cardList.each do |x|
      print "You received the card \"#{x.value}\"\n"
    end
  end


  # helper method to get the human players choice of cards when it's his turn to guess
  def getCard(list)
    alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                '~','!','@','#','$','%','^','&','*','(',')','_','-','=','+','{','}','[',']','<','>','?','/',',','.','`']
    flag = false
    count = -1
    list.each do |a|
      print "#{count += 1}. #{a.value}\n"
    end

    while !flag
      error = false
      index = gets.chomp
      charArray = index.split('')
      charArray.each do |x|
        if alphabet.include? x
          error = true
          break
        end
      end

      if !error
        index = index.chomp.to_i
        if index >= 0 && index <= count
          flag = true
          card = list[index]
        else
          error = true
        end
      end

      if error
        print "Please enter a valid number between #{0} and #{count}.\n"
      end

    end
    card
  end

  # method to mark the player as "removed from from the game", if he makes a bad guess
  def remove
    super
  end

end
