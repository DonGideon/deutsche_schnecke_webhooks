class Personalpronomen < GrammarRule
  def initialize
    super(
      "
*NOM* - *AKK אותך* - *DAT לך*
ich - mich - mir
du - dich - dir
er - ihn - ihm
es - es - ihm
sie - sie - ihr
ihr - euch - euch
wir - uns - uns
sie/Sie - sie/Sie - ihnen/Ihnen
    ",
    'Personalpronomen (mir / mich...)'
    )
  end

  def messageLogic(telegramResponseCreator, messageData)
      if messageData == @displayName
          telegramResponseCreator.textResponse(@prints)
      end
  end
end