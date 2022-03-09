class LinkMaker
  attr_reader :displayName, :commandChar, :instructions

  def initialize(displayName, instructions, website, commandChar, linkText)
    @displayName = displayName
    @instructions = instructions
    @website = website
    @commandChar = commandChar
    @linkText = linkText
  end

  def messageLogic(telegramResponseCreator, conjugateVerb)
    telegramResponseCreator.linkResponse(@website, conjugateVerb, @linkText)
  end
end