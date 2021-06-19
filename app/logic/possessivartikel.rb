class Possessivartikel < GrammarRule
  def initialize
    super(
      "
        *ENG* - *DEU*
        my - mein+
        your - dein+
        his - sein+
        her - ihr+
        its - sein+ 
        our - unser+
        your (plural) - euer/eure+
        their - ihr+
        your (formal) - Ihr+ 
      ",
      'Possessivartikel (mein...}'
    )
  end

  def messageLogic(telegramResponseCreator, messageData)
      if messageData == @displayName
          telegramResponseCreator.textResponse(@prints)
      end
  end
end