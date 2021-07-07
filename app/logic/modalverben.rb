class Modalverben < GrammarRule

    def initialize
        @vergangenheit = 'Vergangenheit'
        @gegenwart = 'Gegenwart'

        super(
            {
                :vergangenheit => "
                    *Vergangenheit*
*ich* - *du* - *er/sie/es* - *Ihr* - *wir* - *sie/Sie*
konnte - konntest - konnte - konntet - konnten - konnten
musste - musstest - musste - musstet - mussten - mussten
wollte - wolltest - wollte - wolltet - wollten - wollten
mochte - mochtest - mochte - mochtet - mochten - mochten *(rarely in use)*
durfte - durftest - durfte - durftet - durften - durften
sollte - solltest - sollte - solltet - sollten - sollten
                ",
                :gegenwart => "
                    *Gegenwart*
*ich* - *du* - *er/sie/es* - *Ihr* - *wir* - *sie/Sie*
kann - kannst - kann - könnt - können - können
muss - musst - muss - müsst - müssen - müssen
will - willst - will - wollt - wollen - wollen
möchte - möchtest - möchte - möchtet - möchten - möchten
darf - darfst - darf - dürft - dürfen - dürfen
soll - sollst - soll - sollt - sollen - sollen
                "
            },
            'Modalverben (können / müssen...)',
            [
                @vergangenheit,
                @gegenwart
            ]
        )
    end

    def messageLogic(telegramResponseCreator, messageData)
        case
            when messageData == @displayName
                telegramResponseCreator.keyboardButtons(
                keyboardOptions,
                'Vergangenheit or Gegenwart?'
                )

            when messageData == @vergangenheit
                telegramResponseCreator.textResponse(@prints[:vergangenheit])

            when messageData == @gegenwart
                telegramResponseCreator.textResponse(@prints[:gegenwart])
        end
    end
end