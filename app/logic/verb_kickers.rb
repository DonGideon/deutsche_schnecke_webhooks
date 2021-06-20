class VerbKickers < GrammarRule
    def initialize
        super(
            "
- *Modalverben* (können, müssen, wollen, möchten, dürfen, sollen)
- *Ob* - whether 
- *Weil* - because
- *Dass* - that
- when using *Indirekte Fragen*
- *Wenn* - if / when or while - conditional (present or past)
- *Als* - when or while - conditional (past when happend once)
            ",
            'Verb Kickers'
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        if messageData == @displayName
            telegramResponseCreator.textResponse(@prints)
        end
    end
end