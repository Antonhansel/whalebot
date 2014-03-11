# Description:
#   Doge Meme
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   doge - Random doge
#
# Author:
#   joel

such_prefix = "http://imgur.com/"

module.exports = (robot) ->
  robot.hear /\b(doge)\b(.*)?/i, (msg) ->
    msg.http('http://imgur.com/r/doge.json?perPage=100')
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          data = json.data
          random_doge = msg.random data

          if msg.match[2] == undefined
            msg.send "#{random_doge.title}"
            msg.send "#{such_prefix}#{random_doge.hash}"
          else
            for doge in data
              if doge.title.toLowerCase().match "#{msg.match[2]}".toLowerCase()
                msg.send "#{doge.title}"
                msg.send "#{such_prefix}#{doge.hash}"
                break
            msg.send "#{random_doge.title}"
            msg.send "#{such_prefix}#{random_doge.hash}"

        catch error
          error_msgs = ["Very fail", "Much exception", "Such crash. WOW"]
          msg.send "#{msg.random error_msgs} #{error}"
