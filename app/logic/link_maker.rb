class LinkMaker
  attr_reader :displayName, :commandChar, :instructions

  def initialize(displayName, instructions, webside, commandChar, linkText)
    @displayName = displayName
    @instructions = instructions
    @webside = webside
    @commandChar = commandChar
    @linkText = linkText
  end

  def messageLogic(telegramResponseCreator, conjugateVerb)
    telegramResponseCreator.linkResponse(@webside, conjugateVerb, @linkText)
  end
end