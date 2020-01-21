require 'rspec'
require_relative '../notificate-atcoder-date'
require 'time'
 
RSpec.describe "Notificate" do
  now_time = Time.now
  now_time_p = Time.local(now_time.year, now_time.month, now_time.day, now_time.hour, 0)

  it "00分以外でも1時間後通知を送る判定がtrueになること" do
    held_time_p = now_time_p + (60*30)
    hours_ago_p = 1
    expect(judge_notification(now_time_p, held_time_p, hours_ago_p)).to be true
  end
  it "00分以外でも24時間後通知を送る判定がtrueになること" do
    held_time_p = now_time_p + (60*60*24) - (60*30)
    hours_ago_p = 24
    expect(judge_notification(now_time_p, held_time_p, hours_ago_p)).to be true
  end
  it "開催時刻には1時間後通知を送る判定がfalseになること" do
    held_time_p = now_time_p
    hours_ago_p = 1
    expect(judge_notification(now_time_p, held_time_p, hours_ago_p)).to be false
  end
  it "24時間後以降の開催について通知を送る判定がfalseになること" do
    held_time_p = now_time_p + (60*60*24*2)
    hours_ago_p = 24
    expect(judge_notification(now_time_p, held_time_p, hours_ago_p)).to be false
  end
end