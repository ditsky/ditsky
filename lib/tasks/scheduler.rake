def powerful
    return {body: "You are the best girlfriend! -Love, Natalie Maximoff", 
            media_url: "https://ditsky.herokuapp.com/scarletWitch.jpg"}
end

def sith
    return {body: "Did you ever hear the tragedy of darth baby the wise? I thought not.
                   It is not a story boobers would tell you. He was so powerful, he could use the force
                   to tell the greatest of girlfriends they require worm...", 
            media_url: ['https://ditsky.herokuapp.com/darthBaby.jpg']}
end

def duck
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
    options = [method(:powerful), method(:sith)]
    content_method = options.sample
    message = content_method.call

    #Send the chosen message
    client.messages.create(
        from: from,
        to: to,
        body: message[:body],
        media_url: message[:media_url]
    )
end

