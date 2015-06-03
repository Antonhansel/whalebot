# Description:
module.exports = (robot) ->
  robot.respond /deploy (.*) to (.*)/i, (msg) ->
    app_package = processApp msg.match[1]
    app = msg.match[1]
    template_id = app_package.template_id
    if app is 0
      msg.send "Sorry but I don't know what #{msg.match[1]} is."
      return
    env = msg.match[2]

    user = "admin"
    pass = process.env.DEPLOY_PASS
    auth = 'Basic ' + new Buffer(user + ':' + pass).toString('base64');
    data = JSON.stringify({
      name: "Whalebot #{app} Deployment"
    })

    robot.http("http://whirlpool.ttagg.com/api/v1/job_templates/#{template_id}/launch/")
      .headers("Authorization": auth, "Content-Type": 'application/json')
      .post(data) (err, res, body) ->
        response = JSON.parse(body)
        if err
          msg.send "Sorry but there was an error: #{err}"
          return
        if res.statusCode != 500
          msg.send "Sure thing. Deploying #{app} to #{env}. The Tower job ID is #{parseInt(response["job"])}"

processApp = (app_string) ->
  switch app_string
    when "hydra"
      return {template_id: 5}
    when "kraken"
      return {template_id: 3}
    else
      return 0
