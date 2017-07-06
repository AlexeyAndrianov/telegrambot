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

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', '/start start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Hello, #{message.from.first_name}! I'm your music guide for today!
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
      lat = rand(-65..65)
      long = rand(-110..110)
      bot.api.send_location(chat_id: message.chat.id, latitude: lat, longitude: long)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Your coordinates are: #{lat}, #{long}"
      )
    end
  end
end
