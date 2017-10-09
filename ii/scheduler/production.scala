import com.twitter.logging.config.BareFormatterConfig
import com.twitter.logging.config.FileHandlerConfig
import com.twitter.logging.config.LoggerConfig
import com.twitter.logging.config._

import com.mgr.scheduler.config.SchedulerServiceConfig

new SchedulerServiceConfig {

  // Ostrich http admin port. Curl this for stats, etc
  admin.httpPort = 8001
  override val thriftPort = 8000

  loggers =
    new LoggerConfig {
      level = Level.DEBUG
      handlers = new FileHandlerConfig {
        filename = "scheduler.log"
        roll = Policy.Daily
      }
    } :: new LoggerConfig {
      node = "stats"
      level = Level.INFO
      useParents = false
      handlers = new FileHandlerConfig {
        filename = "stats.log"
        formatter = BareFormatterConfig
      }
    }
}
