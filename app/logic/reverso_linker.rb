class ReversoLinker < LinkMaker

  def initialize
    super(
      'How Do I conjugate...',
      "Type 'C: ' and the Verb you want to Conjugate (exmp: 'C: Helfen')",
      'https://conjugator.reverso.net/conjugation-german-verb-SEARCHWORD.html',
      'c:',
      'Conjugate'
    )
  end
end