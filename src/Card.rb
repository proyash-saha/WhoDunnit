#-----------------------------------------------------------------------------------------
#  CLASS            : Card
#
#  AUTHOR         : Proyash Saha
#
#  REMARKS       : This class is used to create a new Card object.
#
#-----------------------------------------------------------------------------------------

class Card

  attr_reader :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end

end
