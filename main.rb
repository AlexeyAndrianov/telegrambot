require 'telegram/bot'

TOKEN = '417674830:AAEkssRV0FkEpdN2Dt1IIqpU1TuaJwtmWmo'

STYLES = [
  "Asian",
  "Avant-garde",
  "Blues",
  "Caribbean and Caribbean-influenced",
  "Comedy",
  "Country",
  "Easy listening",
  "Electronic",
  "Folk",
  "Hip hop",
  "Jazz",
  "Latin",
  "Pop",
  "Rock",
  "Metal",
  "Core"
]

CANDY = [
"http://www.partycity.com/images/products/en_us/gateways/candy-2015/candy-by-type/candy-by-type-lollipops.jpg",
"http://chegg.com/play/wp-content/uploads/sites/3/2012/10/halloween-candy-by-phanton-kitty-1.jpg",
"http://images.meredith.com/content/dam/bhg/Images/2014/8/25/RU232726.jpg.rendition.largest.jpg"
]

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', '/start start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Hello, #{message.from.first_name}! I'm your music and travel guide for today!
        Type /commands to view full commands list
        "
      )

    when '/commands'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "
        /start (initialize new conversation, make sure previous session is over)
        /stop (to end session)
        /randomstyle (to choose music style randomly)
        /wiki (to learn something new reading wikipedia)
        /map (go to the random place)
        /givemeacandy
        "
      )

    when '/randomstyle'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: STYLES.sample
      )

    when '/stop', '/stop stop'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Bye, #{message.from.first_name}! See ya next time!"
      )

    when '/map'
      lat = rand(53..54)
      long = rand(27..28)
      bot.api.send_location(chat_id: message.chat.id, latitude: lat, longitude: long)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Your coordinates are: #{lat}, #{long}"
      )
    when '/givemeacandy'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "I am sorry, #{message.from.first_name}! The only candies I got are virtual. But still arent they awesome?
        #{CANDY.sample}"
      )

    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "I am just a bot, dude! Dunno what are you talking about ;("
      )
    end
  end
end
