package botlinera.infrastructure.bot

import botlinera.application.usecases.NearGasStation
import botlinera.domain.valueobject.Coordinates
import botlinera.domain.valueobject.GasStation
import botlinera.infrastucture.adapters.GastStationPersisterMongo
import com.github.kotlintelegrambot.bot
import com.github.kotlintelegrambot.dispatch
import com.github.kotlintelegrambot.dispatcher.location
import com.github.kotlintelegrambot.dispatcher.text
import com.github.kotlintelegrambot.entities.ChatId.Companion.fromId
import java.lang.System.getenv

class TelegramBot {
    fun startPolling() {
        initBot()
    }

    private fun initBot() = bot {
        token = getenv("TELEGRAM_BOT_TOKEN")
        dispatch {
            text {
                bot.sendMessage(fromId(message.chat.id), text = text)
            }
            location {
                getNearGasStations(location.latitude, location.longitude)
                    .forEach { gasStation ->
                        bot.sendMessage(
                            fromId(message.chat.id), text = gasStation.formatted()
                        )
                        bot.sendLocation(
                            fromId(message.chat.id),
                            gasStation.latitude().toFloat(),
                            gasStation.longitude().toFloat()
                        )
                    }
            }
        }
    }.startPolling()

    private fun getNearGasStations(latitude: Float, longitude: Float): List<GasStation> {
        val gasStationPersister = GastStationPersisterMongo(getenv("DATABASE_URL"))
        return NearGasStation(gasStationPersister).execute(Coordinates(latitude.toDouble(), longitude.toDouble()))
    }
}
