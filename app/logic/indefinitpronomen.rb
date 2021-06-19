class Indefinitpronomen < GrammarRule
    def initialize
        super(
            "
            *NOM*
                m - einer -
                    Wo ist mein Schlüssel? Im Schrank ist einer.
                n - eins -
                    Wo ist das Regal? Im treppenhaus steht eins.
                f - eine - 
                    Haben Sie eine Banane? Da liegt eine.
                pl - welche - 
                    Wo sind alle Datteln? Da sind welche.
            
*AKK*
                m - einen / keinen -
                    Ich mache mir einen Espresso. Möchtest du auch einen?
                n - eins / keins -
                    Wo ist dein Mehl (n)? Ich habe keins.
                f - eine / keine - 
                    Ich mache mir eine Tasse Kaffee. Möchtest du keine?
                pl - welche / keine - 
                    Ich kaufe mir ein paar Pflanzen. Möchtest du auch welche?
            ",
            'Indefinitpronomen (einer / einen...)'
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        if messageData == @displayName
            telegramResponseCreator.textResponse(@prints)
        end
    end
end