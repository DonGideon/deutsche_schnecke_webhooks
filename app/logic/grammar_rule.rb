class GrammarRule
  attr_reader :displayName, :keyboardOptions

  def initialize(prints, displayName, keyboardOptions = [])
    @prints = prints
    @displayName = displayName
    @keyboardOptions = keyboardOptions
  end

  def messageLogic
  end
end