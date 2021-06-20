class Modalverben < GrammarRule
    def initialize
        super(
            "
            *ich*-*du*-*er/sie/es*-*Ihr*-*wir*-*sie/Sie*
            kann-kannst-kann-könnt-können-können
            muss-musst-muss-müsst-müssen-müssen
            will-willst-will-wollt-wollen-wollen
            möchte-möchtest-möchte-möchtet-möchten-möchten
            darf-darfst-darf-dürft-dürfen-dürfen
            soll-sollst-soll-sollt-sollen-sollen
            ",
            'Modalverben (können / müssen...)'
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        if messageData == @displayName
            telegramResponseCreator.textResponse(@prints)
        end
    end
end