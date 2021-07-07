class ReflexiveVerben < GrammarRule
    def initialize
        super(
            "
🧑‍💼 - *AKK* - *DAT*
*ich* - mich - mir
*du* - dich - dir
*er/sie/es* - sich
*Ihr* - euch
*wir* - uns
*sie* - sich
            ",
            'Reflexive Verben (sich...)'
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        if messageData == @displayName
            telegramResponseCreator.textResponse(@prints)
        end
    end
end