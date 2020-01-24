require './https_request'
require './scrape_atcoder_contest_day'
require 'time'

def create_message_body(header, contest, after_hour)
    message = "******* [BOT INFORMATION (Beta))] *******\n"
    message += "The Contest will start about #{after_hour} hour later !!\n\n"
    (header.length).times do |i|
        message += "#{header[i]}: #{contest[i]}\n"
    end
    return {"text": message}
end

def judge_notification(now_time_p, held_time_p, hours_ago_p)
    if now_time_p + (hours_ago_p * 60 * 60) == held_time_p then
        return true
    elsif now_time_p + (hours_ago_p * 60 * 60) > held_time_p && now_time_p + ((hours_ago_p - 1) * 60 * 60) < held_time_p
        return true
    else
        return false
    end
end

# scraping future contests from atcoder contests page
contests = scrape_atcoder_contest_day
contest_header = contests.shift

# notification contests will be held today or tomorrow to slack
now_time = Time.now
now_time = Time.local(now_time.year, now_time.month, now_time.day, now_time.hour, now_time.min) # truncate minutes and seconds
notification_hours_ago = [1, 24]
contests.each do |contest|
    contest[0] = Time.parse(contest[0])
    held_time = contest[0]
    notification_hours_ago.each do |hours_ago|
        if judge_notification(now_time, held_time, hours_ago) then
            body = create_message_body(contest_header, contest, hours_ago)
            response = https_request(ENV['SLACK_URL'], body)
        end
    end
end
