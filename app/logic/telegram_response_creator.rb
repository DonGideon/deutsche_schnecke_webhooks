require 'net/http'
require 'uri'
require 'json'

class TelegramResponseCreator

    def initialize(chatId)
        @chatId = chatId
        @token = ENV["TOKEN"]
    end
# not in use, for creating inline buttons
    def inlineKeyboardButtons(buttons, header)
        inline_keyboard_buttons = buttons.map do |button|
            [
                {
                    text: button[:text],
                    callback_data: button[:callback_data]
                }
            ]
        end

        sendResponse({
            text: header,
            reply_markup: {
                inline_keyboard: inline_keyboard_buttons
            }
        })
    end

    def keyboardButtons(buttons, header)
        keyboard_buttons = buttons.map do |button|
            [
                {
                    text: button
                }
            ]
        end

        sendResponse({
            text: header,
            reply_markup: {
                one_time_keyboard: true,
                keyboard: keyboard_buttons
            }
        })
    end

    def textResponse(text)
        sendResponse({
            text: text
        })
    end

    def linkResponse(website, searchWord, linkText)
        sendResponse({
            text: "Click here 👇",
            reply_markup: {
                inline_keyboard: [
                    [
                        {
                            text: "#{linkText} #{searchWord.capitalize}",
                            url: website.sub('SEARCHWORD', searchWord)
                        }
                    ]
                ]
            }
        })
    end


    def documentResponse(documentPath)
        uri = URI.parse("https://api.telegram.org/bot#{@token}/sendDocument?chat_id=#{@chatId}")
        request = Net::HTTP::Post.new(uri.request_uri)
        form_data = [["document", File.open(documentPath)]]
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        #set the file to send with form-data
        request.set_form form_data, 'multipart/form-data'
    
        # Send the request
        response = http.request(request)
    end

    def sendResponse(message)
        uri = URI.parse("https://api.telegram.org/bot#{@token}/sendMessage")
    
        header = {'Content-Type': 'application/json'}
        user = {
          chat_id: @chatId,
          parse_mode: 'markdown'
        }.merge(message)
    
        # Create the HTTP objects
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.request_uri, header)
        http.use_ssl = true
        request.body = user.to_json
    
        # Send the request
        response = http.request(request)
    end
end