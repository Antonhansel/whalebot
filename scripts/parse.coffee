Parser = require("xml2js").Parser
moment = require("moment")

module.exports = (robot) ->
  robot.respond /parse status/i, (msg) ->
    msg.http("http://status.parse.com/history.rss").get() (err, res, body) ->
      if err
        msg.send "Parse says: #{err}"
        return
      (new Parser).parseString body, (err, json)->
        if json.channel.item
          msg.send "Parse Status: " + json.channel.item[0].title + " -> " + json.channel.item[0].link +  " -- Last Updated: " + moment(json.channel.pubDate).fromNow()
        else
          msg.send "Parse Status: All Systems Operational -- Last Updated: " + moment(json.channel.pubDate).fromNow()
