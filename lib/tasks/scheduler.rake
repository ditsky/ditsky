task :best_gf => :environment do
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_AUTH"]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = ENV["TWILIO_PHONE"] # Your Twilio number
    to = ENV["GF_PHONE"] # Your mobile phone number

    client.messages.create(
    from: from,
    to: to,
    body: "You are the best girlfriend! -Love, Natalie Maximoff "
    )
end

task :best_bf => :environment do
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_AUTH"]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = ENV["TWILIO_PHONE"] # Your Twilio number
    to = "+19783828773" # Your mobile phone number

    client.messages.create(
    from: from,
    to: to,
    body: "You are the best girlfriend! -Love, Natalie Maximoff ",
    media_url: ['app/assets/images/darthBaby.jpg']
    )
end