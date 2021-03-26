def powerful
    return {body: "You could have had a girl like me, but you chose a crusty gamer boy instead.
                  Quite good at girlfriend, but could use some help with her decision making...", 
            image: "scarletWitch.jpg"}
end

def sith
    return {body: "Did you ever hear the tragedy of darth baby the wise? I thought not.
                   It is not a story boobers would tell you. He was so powerful, he could use the force to tell the greatest of girlfriends they require worm...", 
            image: 'darthBaby.jpg'}
end

def duck
    return {body: "MOMMMM!!! HELP!! MAN-DAD DO SQUEEZE!! HUNGY DUCK!",
            image: 'duckSqueeze.jpg'}
end

task :best_gf => :environment do
    #Authenticate a Twilio Client
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_AUTH"]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    #Set phone numbers
    from = ENV["TWILIO_PHONE"]
    to = ENV["GF_PHONE"]

    #Pick a message option
    options = [method(:powerful), method(:sith), method(:duck)]
    content_method = options.sample
    message = content_method.call

    #Send the chosen message
    client.messages.create(
        from: from,
        to: to,
        body: message[:body],
        media_url: [ENV["APP_HOST"] + message[:image]]
    )
end

