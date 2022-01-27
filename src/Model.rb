#-----------------------------------------------------------------------------------------
#  CLASS         : Model
#
#  AUTHOR        : Proyash Saha
#
#  REMARKS       : To create a game that involves deduction to
#                  determine the “who, where and how” of a crime.
#
#-----------------------------------------------------------------------------------------

class Model

  def initialize(peopleList, placeList, weaponList)
    @peopleList = peopleList
    @placeList = placeList
    @weaponList = weaponList
    @peopleAnswer = nil
    @placeAnswer = nil
    @weaponAnswer = nil
    @allCardList = Array.new
    @playerList = nil
  end


  def setPlayers(players)
    showAllInfo
    size = players.size
    playerNumber = 0
    players.each do |x|
      x.setup(size,playerNumber,@peopleList,@placeList,@weaponList)
      playerNumber += 1
    end
    @playerList = players
  end


  def setupCards
    pplList = @peopleList.shuffle   # shuffling the peopleList and storing it in a new array
    plcList = @placeList.shuffle    # shuffling the placeList and storing it in a new array
    wpnList = @weaponList.shuffle   # shuffling the weaponList and storing it in a new array

    @peopleAnswer = pplList[0].value    # choosing an answer card from the peopleList
    @placeAnswer = plcList[0].value     # choosing an answer card from the placeList
    @weaponAnswer = wpnList[0].value    # choosing an answer card from the weaponList

    # inserting all the cards from peopleList into allCardList
    index = 1
    size = pplList.size-1
    size.times {|i| @allCardList << pplList[index]; index +=1}

    # inserting all the cards from placeList into allCardList
    index = 1
    size = plcList.size-1
    size.times {|i| @allCardList << plcList[index]; index +=1}

    # inserting all the cards from weaponList into allCardList
    index = 1
    size = wpnList.size-1
    size.times {|i| @allCardList << wpnList[index]; index +=1}

    # shuffling the allCardList that has all the cards fom peopleList, placeList and weaponList but none of the answer cards
    @allCardList.shuffle!

    # distributing all the cards in allCardList to the players one at a time based on the player's index
    index = 0
    size = @playerList.size
    @allCardList.each do |x|
      @playerList[index%size].setCard(x)
      index += 1
    end

    @playerList.each do |x|
      if x.class == InteractivePlayer
        x.myCardList # printing all the cards received by the human player
      end
    end
  end


  def play
    print "\n"
    tempSize = @playerList.size
    gameOver = false
    index = 0
    pos = index%@playerList.size # active player's index
    guess = @playerList[pos].getGuess # getting the guess of the active player

    while(!gameOver)
      sleep(2)
      if !guess.isAccusation && @playerList[pos].class == Player
        if guess.person.value == @peopleAnswer && guess.place.value == @placeAnswer && guess.weapon.value == @weaponAnswer
          guess = Guess.new(guess.person,guess.place,guess.weapon,true)
        end
      end

      # if guess is an accusation
      if guess.isAccusation
        print " Player #{pos}: Accusation: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}.\n"
        # checking if guess is correct
        if guess.person.value == @peopleAnswer && guess.place.value == @placeAnswer && guess.weapon.value == @weaponAnswer
          gameOver = true
          print "Player #{pos} won the game.\n"  # active player wins the game
        else
          # if guess is wrong, the active player is removed from the game
          @playerList[pos].remove
          print "Player #{pos} made a bad accusation and was removed from the game.\n"
          tempSize -= 1
          if tempSize == 1  # if there is only one player left in the game, that player wins the game
            gameOver = true
            print "Player #{(pos+1)%@playerList.size} won the game.\n"
          end
        end

      # if guess is an suggestion
      else
        print " Player #{pos}: Suggestion: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}.\n"
        flag = false
        temp = pos+1
        x = temp%@playerList.size  # index of the player after the active player

        while  !flag && x!=pos
          print "Asking player #{x}.\n"
          list = @playerList[x].canAnswer(pos, guess)
          if  list != nil  # if the player can answer
            if @playerList[x].class == Player # if it is a computer player
              flag = true
              @playerList[pos].receiveInfo(x, list) # active player receives info about his guess being refuted
              print "Player #{x} answered.\n"

            elsif @playerList[x].class == InteractivePlayer  # if it is the human player
              flag = true
              if list.size == 1 # if he has only one card to refute the active player's guess
                card = list[0]
              else  # if he has more than one card to refute the active player's guess
                card = @playerList[x].getCard(list)
              end
              @playerList[pos].receiveInfo(x, card) # active player receives info about his guess being refuted
            end
            temp += 1 # moving on to the next player to see if he can answer
          else
            # if the computer player could not answer
            if @playerList[x].class != InteractivePlayer
              print "Player #{x} could not answer.\n"
            end
            temp += 1
            x = temp%@playerList.size
          end
        end

        if !flag
          # if no one could answer
          print "No one could answer.\n"
          @playerList[pos].receiveInfo(-1, nil)
        end
      end

      # if game is not over yet
      if !gameOver
        index += 1
        pos = index%@playerList.size # active player's index
        if @playerList[pos].outOfGame # if active player is out of the game
          index += 1
          pos = index%@playerList.size # next active player's index
        end
        guess = @playerList[pos].getGuess # getting the guess of the active player
      end
    end
  end


  # helper method to display all the people , place and weapons involved in the game
  def showAllInfo
    print "\nHere are the names of the suspects:\n"
    size = @peopleList.size-1
    size.times {|i| print "#{@peopleList[i].value}, "}
    print "#{@peopleList[size].value}\n"
    sleep(2)

    print "\nHere are all the locations:\n"
    size = @placeList.size-1
    size.times {|i| print "#{@placeList[i].value}, "}
    print "#{@placeList[size].value}\n"
    sleep(2)

    print "\nHere are all the weapons:\n"
    size = @weaponList.size-1
    size.times {|i| print "#{@weaponList[i].value}, "}
    print "#{@weaponList[size].value}\n"
    sleep(2)
  end

end
