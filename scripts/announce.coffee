# Description:
#   "Accepts JSON POST data posts it to a room"
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLs:
#   POST /hubot/announce
#     message = <message>
#     room = <room>
#
#   curl -X POST http://localhost:8080/hubot/say -d message=lala -d room='#dev'
#
# Author:
#   Addam Hardy

module.exports = (robot) ->
  robot.router.post "/hubot/announce/:room", (req, res) ->

    data = req.body
    message = data['message']
    room = req.params.room
    message = data.message
    color = data.color
    from = data.from

    robot.http("http://whalebot.herokuapp.com/hubot/hipchat?room_id="+room+"&from="+from+"&message="+message+"&color="+color+")
      .get() (err, res, body) ->
        console.log body

    res.writeHead 200, {'Content-Type': 'text/plain'}
    res.end 'Sent!\n'
