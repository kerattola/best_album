require File.expand_path('../config/environment',__dir__)

require 'telegram/bot'

token = "2133302534:AAHbzcaIJryJV4sXnAYgLG23sE_5i20p8EQ"

Telegram::Bot::Client.run(token) do |bot|
	bot.listen do |message|
        
		case message.text
		when /^\/start/
			bot.api.send_message(
				chat_id: message.chat.id,
				text: "Hello, #{message.from.first_name}!")

		when /^\/help/
			bot.api.send_message(chat_id: message.chat.id, text: "/start - start working")
			bot.api.send_message(chat_id: message.chat.id, text: "/artists - to see our list of artists and reviews")
			bot.api.send_message(chat_id: message.chat.id, text: "/scores - to see the ratings for each album")
			bot.api.send_message(chat_id: message.chat.id, text: "/stop - finish work")
			bot.api.send_message(chat_id: message.chat.id, text: "/help")
			
					
		when /^\/artists/
			@artists = Artist.all
			arr = @artists.map { |art| art.name }
			markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: arr)
			   #one_time_keyboard: true
			bot.api.send_message(
				chat_id: message.chat.id,
				text: "all artists", reply_markup: markup)

		# when /^\/albums/
		# 	@albums= Album.all
		# 	arr = @albums.map { |art| art.title}
		# 	markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: arr)

		# 	bot.api.send_message(
		# 		chat_id: message.chat.id,
		# 		text: "all albums", reply_markup: markup)

		when /^\/scores/
			@albums= Album.all
			@albums.each do |album|
			bot.api.send_message(
			    chat_id: message.chat.id,
			    text: "#{album.title} - Score: #{album.score.number}")
			end

	    when /^\/stop/
			kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
		    bot.api.send_message(
				chat_id: message.chat.id,
			    text: "Bye!", reply_markup: kb)

		when /^\w/
			@artists = Artist.all
        	if @artists.map { |art| art.name }.include?(message.text)
        		art = Artist.where("name LIKE ?", "%#{message.text}%")

        		@review = Article.find_by(artist_id: art)
        		
        	    bot.api.send_message(
				    chat_id: message.chat.id,
				    text: "Artist: #{@review.artist.name}, Album: #{@review.album.title}, Label: #{@review.label}, Year: #{@review.year}, Reviewer: #{@review.reviewer}, Date: #{@review.review_date}")
                
        	else 
        		bot.api.send_message(
				   chat_id: message.chat.id,
				   text: "Can't find")
			end
		end
    end
end