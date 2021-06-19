class DictccLinker < LinkMaker

  def initialize
    super(
      'Translate and Gender of...',
      "Type 'T: ' and the Word you want to Translate or find its Gender (exmp: 'T: Schnecke')",
      'https://www.dict.cc/?s=SEARCHWORD',
      't:',
      'Translate'
    )
  end
end