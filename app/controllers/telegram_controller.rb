require './app/logic/telegram_response_creator'

CALL_BACK_QUERY = "CALL_BACK_QUERY"
SIMPLE_MESSAGE_OR_KEYBOARD = "SIMPLE_MESSAGE_OR_KEYBOARD"

class TelegramController < ApplicationController
    skip_before_action :verify_authenticity_token

    def processor
        # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        # puts Adjektivdeklination.prints
        # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        if params[:message].nil?
            User.new(first_name: params[:my_chat_member][:old_chat_member][:first_name], user_name: params[:my_chat_member][:old_chat_member][:username]).save
        else
            messageType = !!params[:callback_query] ? CALL_BACK_QUERY : SIMPLE_MESSAGE_OR_KEYBOARD
            chatId = messageType === CALL_BACK_QUERY ? params[:callback_query][:message][:chat][:id] : params[:message][:chat][:id]

            telegramResponseCreator = TelegramResponseCreator.new(chatId)

            case
                # when messageType == CALL_BACK_QUERY
                #     User.new(first_name: params[:callback_query][:from][:first_name], last_name: params[:callback_query][:from][:last_name], user_name: params[:callback_query][:from][:username], message: params[:callback_query][:data]).save
                #     case 
                #         when params[:callback_query][:data].include?("akkusativ_or_dativ")
                #             AkkusativOrDativ.messageLogic(telegramResponseCreator, params[:callback_query][:data])
                    
                #         when params[:callback_query][:data].include?("personalpronomen")
                #             Personalpronomen.messageLogic(telegramResponseCreator, params[:callback_query][:data])
                    
                #         when params[:callback_query][:data].include?("possessivartikel")
                #             Possessivartikel.messageLogic(telegramResponseCreator, params[:callback_query][:data])
                
                #         when params[:callback_query][:data].include?("adjektivdeklination")
                #             Adjektivdeklination.messageLogic(telegramResponseCreator, params[:callback_query][:data])
                
                #         when params[:callback_query][:data].include?("indefinitpronomen")
                #             Indefinitpronomen.messageLogic(telegramResponseCreator, params[:callback_query][:data])
                
                #         when params[:callback_query][:data] == "how_to_conjugate"
                #             telegramResponseCreator.textResponse("Type 'C: ' and the Verb you want to Conjugate (exmp: 'C: Helfen')")
                
                #         when params[:callback_query][:data] == "translate_and_gender"
                #             telegramResponseCreator.textResponse("Type 'T: ' and the Word you want to Translate or find its Gender (exmp: 'T: Schnecke')")
                #     end
                when messageType == SIMPLE_MESSAGE_OR_KEYBOARD
                    User.new(first_name: params[:message][:chat][:first_name], last_name: params[:message][:chat][:last_name], user_name: params[:message][:chat][:username], message: params[:message][:text]).save
                    theWord = params[:message][:text]
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
            end
        end
        
        render body: nil
        
    end
end
