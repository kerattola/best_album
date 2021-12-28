require File.expand_path('../config/environment',__dir__)

require 'telegram/bot'

token = "2133302534:AAHkte49_2tYY3TjdpeJ97TCuKYyJ__WN6I"

Telegram::Bot::Client.run(token) do |bot|
	bot.listen do |message|

		case message

		when Telegram::Bot::Types::CallbackQuery
			if message.data == 'kstart'
				bot.api.send_message(chat_id: message.from.id, text: "Hello, #{message.from.first_name}!")
            end

            if message.data == 'kstop'
            	kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
				bot.api.send_message(chat_id: message.from.id, text: "Bye!", reply_markup: kb)
            end

            if message.data == 'kartists'
				@artists = Artist.all
				arr = @artists.map { |art| art.name }
				markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: arr)
				   #one_time_keyboard: true
				bot.api.send_message(chat_id: message.from.id,text: "all artists", reply_markup: markup)
			end

			if message.data == 'kscores'
				@albums= Album.all
				@albums.each do |album|
					bot.api.send_message(chat_id: message.from.id,text: "#{album.title} - Score: #{album.score.number}")
				end
			end


        when Telegram::Bot::Types::Message

		    if message.text == '/start'
			    bot.api.send_message(chat_id: message.chat.id,text: "Hello, #{message.from.first_name}!")
			end

		    if message.text == '/help'
				kb = [
					Telegram::Bot::Types::InlineKeyboardButton.new(text: 'start', callback_data: 'kstart'),
	                Telegram::Bot::Types::InlineKeyboardButton.new(text: 'stop', callback_data: 'kstop'),
	                Telegram::Bot::Types::InlineKeyboardButton.new(text: 'artists', callback_data: 'kartists'),
	                Telegram::Bot::Types::InlineKeyboardButton.new(text: 'scores', callback_data: 'kscores'),
	            ]
	            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
	            bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
			end
					
		    if message.text =~ /^\/artists/
				@artists = Artist.all
				arr = @artists.map { |art| art.name }
				markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: arr)
				   #one_time_keyboard: true
				bot.api.send_message(chat_id: message.chat.id,text: "all artists", reply_markup: markup)
			end

		   if message.text =~ /^\/scores/
				@albums= Album.all
				@albums.each do |album|
					bot.api.send_message(chat_id: message.chat.id,text: "#{album.title} - Score: #{album.score.number}")
				end
			end


	        if message.text =~ /^\/stop/
				kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
			    bot.api.send_message(chat_id: message.chat.id,text: "Bye!", reply_markup: kb)
			end

		    if message.text =~ /^\w/
				@artists = Artist.all
	        	if @artists.map { |art| art.name }.include?(message.text)
	        		art = Artist.where("name LIKE ?", "%#{message.text}%")

	        		@review = Article.find_by(artist_id: art)
	        		
	        	    bot.api.send_message(
					    chat_id: message.chat.id,
					    text: "Artist: #{@review.artist.name}, Album: #{@review.album.title}, Label: #{@review.label}, Year: #{@review.year}, Reviewer: #{@review.reviewer}, Date: #{@review.review_date}")
	                
	        	else 
	        		bot.api.send_message(chat_id: message.chat.id,text: "Can't find")
				end
			end
		end
    end
end