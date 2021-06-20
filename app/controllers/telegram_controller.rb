require './app/logic/telegram_response_creator'

class TelegramController < ApplicationController
    skip_before_action :verify_authenticity_token

    def processor
        if params[:message].nil?
            User.new(first_name: params[:my_chat_member][:old_chat_member][:first_name], user_name: params[:my_chat_member][:old_chat_member][:username]).save
        else
            chatId = params[:message][:chat][:id]
            telegramResponseCreator = TelegramResponseCreator.new(chatId)

            User.new(first_name: params[:message][:chat][:first_name], last_name: params[:message][:chat][:last_name], user_name: params[:message][:chat][:username], message: params[:message][:text]).save
            if theWord = params[:message][:text]
                theWordSimplefy = theWord.downcase.delete(' ').delete('/')
                grammarRules = [
                    Adjektivdeklination.new,
                    AkkusativOrDativ.new,
                    Personalpronomen.new,
                    Possessivartikel.new,
                    Indefinitpronomen.new
                ]
                linkers = [
                    ReversoLinker.new,
                    DictccLinker.new
                ]
                case
                    when correctGrammarRule =  grammarRules.find { |grammarRule| (grammarRule.keyboardOptions + [grammarRule.displayName]).include?(theWord) }
                        correctGrammarRule.messageLogic(telegramResponseCreator, theWord)

                    when correctLinker =  linkers.find { |link| link.displayName == theWord }
                        telegramResponseCreator.textResponse(correctLinker.instructions)
            
                    when theWordSimplefy == 'h' || theWordSimplefy == 'hilfe' || theWordSimplefy == 'help' || theWordSimplefy == 'start'
                        buttons = (grammarRules + linkers).map { |option| option.displayName }
                        telegramResponseCreator.keyboardButtons(buttons, '🐌 WÄHLE!')
                    
                    when correctLinker =  linkers.find { |link| theWordSimplefy.include?(link.commandChar) }
                        wordToUse = theWord.split.last
                        correctLinker.messageLogic(telegramResponseCreator, wordToUse)
                        
                    when theWordSimplefy == ('🐌')
                        telegramResponseCreator.textResponse('❤️')
                end
            else
                telegramResponseCreator.textResponse('🐌❤️')
            end
        end
        
        render body: nil
        
    end
end
