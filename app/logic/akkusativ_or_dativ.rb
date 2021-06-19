class AkkusativOrDativ < GrammarRule

    def initialize
        @präpositionen = 'Präpositionen'
        @fragen = 'Fragen'

        super(
            {
            :präpositionen => "
                *AKK*
                - bis (till)
                - gegen (against, towards)
                - um (location: around / time: at)
                - durch (through)
                - ohne (without)
                - entlang (along)
            
*DAT*
                - aus (from originally)
                - von (from, of)
                - zu (to)
                - nach (to - streets, cities, countries, after)
                - mit (with)
                - seit (since)
                - bei (at - name of people/companies, during/while)
                - Gegenüber (in front of (will come after the noun))
            ",
            :fragen => "
                *AKK*
                - Wohin? Where to (with action)
                - Was? what
                - Wen? who
            
*DAT*
                - Wo? where
                - Wann? when
                - Wem? whom
            "
            },
            'Akkusativ Or Dativ?',
            [
                @präpositionen,
                @fragen
            ]
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        case
            when messageData == @displayName
                telegramResponseCreator.keyboardButtons(
                keyboardOptions,
                'Präpositionen or Fragen?'
                )

            when messageData == @präpositionen
                telegramResponseCreator.textResponse(@prints[:präpositionen])

            when messageData == @fragen
                telegramResponseCreator.textResponse(@prints[:fragen])
        end
    end
end