require './https_request'
require './scrape_atcoder_contest_day'
require 'time'

def create_message_body(header, contest, after_hour)
    message = "******* [BOT INFORMATION (Beta))] *******\n"
    message += "The Contest will start #{after_hour} hour later !!\n\n"
    (header.length).times do |i|
        message += "#{header[i]}: #{contest[i]}\n"
    end
    return {"text": message}
end

# scraping future contests from atcoder contests page
contests = scrape_atcoder_contest_day
contest_header = contests.shift

# notification contests will be held today or tomorrow to slack
now_time = Time.now
now_time = Time.local(now_time.year, now_time.month, now_time.day, now_time.hour)
notification_seconds_ago = [1 * 60 * 60, 24 * 60 * 60]
contests.each do |contest|
    contest[0] = Time.parse(contest[0])
    held_time = contest[0]
    notification_seconds_ago.each do |seconds_ago|
        if now_time + seconds_ago == held_time
            body = create_message_body(contest_header, contest, seconds_ago / 3600)
            response = https_request(ENV['SLACK_URL'], body)
        end
    end
end
