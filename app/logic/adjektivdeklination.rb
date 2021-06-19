class Adjektivdeklination < GrammarRule

    def initialize
        @bestimmte = 'Bestimmte Adjektive (die...)'
        @unbestimmte = 'Unbestimmte Adjektive (ein...)'

        super(
            {
            :bestimmte_adjektive => "
                *NOM*
                m - der gute Freund
                n - das gute Projekt
                f - die gute Freundin
                pl - die guten Freunde
*AKK*
                m - den guten Freund
                n - das gute Projekt
                f - die gute Freundin
                pl - die guten Freunde
*DAT*
                m - dem guten Freund
                n - dem guten Projekt
                f - der guten Freundin
                pl - den guten Freunden
            ",
            :unbestimmte_adjektive => "
                *NOM*
                m - ein guter Freund
                n - ein gutes Projekt
                f - eine gute Freundin
                pl - gute Freunde+
*AKK*
                m - einen guten Freund
                n - ein gutes Projekt
                f - eine gute Freundin
                pl - gute Freunde+
*DAT*
                m - einem guten Freund
                n - einem guten Projekt
                f - einer guten Freundin
                pl - guten Freunden
            "
            
            },
            'Adjektivdeklination',
            [
                @bestimmte,
                @unbestimmte
            ]
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        case
            when messageData == @displayName
                telegramResponseCreator.keyboardButtons(
                keyboardOptions,
                'Bestimmte Adjektive or Unbestimmte Adjektive?'
                )
            when messageData == @bestimmte 
                telegramResponseCreator.textResponse(@prints[:bestimmte_adjektive])

            when messageData == @unbestimmte
                telegramResponseCreator.textResponse(@prints[:unbestimmte_adjektive])
        end
    end
end