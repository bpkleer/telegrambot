library("telegram.bot")
bot <- Bot(token = bot_token("RTelegramBot"))

updates <- bot$getUpdates()
updates

print(bot$getMe())

updates <- bot$get_updates(allowed_updates = "message")
