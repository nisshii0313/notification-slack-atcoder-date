# Notificate AtCoder Date to Slack (Beta Version)
This notifier tells your workspace contest date of [AtCoder](https://atcoder.jp/).
In first setting, it send notification 1 and 24 hours before the contest.

This is not yet completed and in testing !!

# Usage
## Add Webhook App
(Note: I use Slack in Japan, so the text are Japanese. The following text may be different from the English version.)

First, add "Incoming Webhook" to your workspace.

Access `https://(your workspace).slack.com/apps`  
-> Search "Incoming Webhook"  
-> "Add to Slack"  
-> Specify post channel and "add Incomming Webhook Integration"

In next page, note "Webhook URL". This is used later.

## Fork This Repository
Fork this repo.  
Next, add a new secret in settings tab.
"Setting" -> "secrets" -> "Add a new secret"

Name: SLACK_URL  
Value: ("Webhook URL" you noted.)

That's all you do.

# How it works
## Scraping
To get information of feature contests, Scraping is used by using ruby gem "Nokogiri".
Target web site is [AtCoder contests page](https://atcoder.jp/contests?lang=ja).

## Post to Slack
To send messages to Slack, "Incoming Webhook" is used.
Thanks to this, we can send messages by using http requests.
Messages are sent by granting the following json as request body.

```json
{
    "text": "Hello Slack!"
}
```

"Incoming Webhook" can only send messages.

## Regular Execution
Notification program are executed regularly. (every hour by default.)
GitHub Actions is used for this.
Scheduling is set to execute every hour at 0 minutes.

# Features
It is much time to install gem "nokogiri".
This gem is used every hours, so I want to use in one install.
It is inefficient.

I am waiting your feedbacks !!

# License

The MIT License 2019 EisKern

The full license is [here](/LICENSE).

# Author
[EisKern](https://eiskern.com/)
