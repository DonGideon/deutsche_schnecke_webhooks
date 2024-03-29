class Konjunktiv2 < GrammarRule
    def initialize
        super(
            "
- *wären* (sein) - I would like to be
- *hätten* (haben) - I would like to have
examples:
- Ich *wäre* gern mehr entspannt
- Ich *hätte* gern noch eine Schnecke
- Ich *würde* das sehr nett finden, wenn du mich jeden Tag anrufen *würdest*.
            ",
            'Konjunktiv2 (wären / hätten)'
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        if messageData == @displayName
            telegramResponseCreator.textResponse(@prints)
        end
    end
end