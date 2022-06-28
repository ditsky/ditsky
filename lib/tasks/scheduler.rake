require 'json'

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

def princess
    return {body: "Momther... I crave the juicy flesh. Where is the juicy?? Boober want to do eat you filthy pauper. Don't make me do the slap momther. I will not hold back anymore momther; you have teased me long enough. Father says you is besb giwrlfriend. But is best momther??
        HMMMMMMMM???!! (yes) but feed me dumb hoe. I am perfect baby angel princess. PERFECT ANGEL BOOBER BABY PRINCESS!!!!",
            image: 'angyBoo.jpg'}
end

def duck
    return {body: "MOMMMM!!! HELP!! MAN-DAD DO SQUEEZE!! HUNGY DUCK!",
            image: 'duckSqueeze.jpg'}
end

def robin
    exclamations = File.read('lib/tasks/exclamations.json')
    setups = JSON.parse(exclamations)
    punchlines = File.read('lib/tasks/punchlines.json')
    insideJokes = JSON.parse(punchlines)
    images = File.read('lib/tasks/nwimages.json')
    imageUrls = JSON.parse(images)
    message = setups['exclamations'].sample + " girlfriend, " + insideJokes['punchlines'].sample
    image = imageUrls['images'].sample

    return {body: message, image: image}

end

def birth
    return {body: "Happy Birthday sweetie! For this special edition 8pm best girlfriend I present to you a cat in a suit. What a marvel it is to be     around something so handsome and sweet!",
            image: 'catinsuit.jpg'}
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
    d = DateTime.now
    if d.month.to_s == ENV["GF_BIRTHMONTH"] and d.day.to_s == ENV["GF_BIRTHDAY"]
        content_method = method(:birth)
    else
        options = [method(:powerful), method(:sith), method(:duck), method(:princess), method(:robin)]
        content_method = options.sample
    end
    message = content_method.call

    #Send the chosen message
    client.messages.create(
        from: from,
        to: to,
        body: message[:body],
        media_url: [ENV["APP_HOST"] + message[:image]]
    )
end

task :best_bf, [:test_message] => :environment do |task, args|
    #Authenticate a Twilio Client
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_AUTH"]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    #Set phone numbers
    from = ENV["TWILIO_PHONE"]
    to = ENV["GF_PHONE"]

    content_method = method(args[:test_message])
    message = content_method.call

    #Send the chosen message
    client.messages.create(
        from: from,
        to: to,
        body: message[:body],
        media_url: [ENV["APP_HOST"] + message[:image]]
    )
end

