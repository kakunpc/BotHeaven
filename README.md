Bot Heaven
====

Bot farm of SLACK.

Heaven is higher than a cloud.

[![Code Climate](https://codeclimate.com/github/alfa-jpn/BotHeaven/badges/gpa.svg)](https://codeclimate.com/github/alfa-jpn/BotHeaven)
[![Build Status](https://travis-ci.org/alfa-jpn/BotHeaven.svg?branch=master)](https://travis-ci.org/alfa-jpn/BotHeaven)
[![Coverage Status](https://coveralls.io/repos/alfa-jpn/BotHeaven/badge.svg)](https://coveralls.io/r/alfa-jpn/BotHeaven)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Install
This is rails application.
- System Required
  - Ruby (>2.0.0)
  - Bundler

### 1. Deploy bot heaven.
### 2. Set Environments.

```shell
SLACK_TEAM_ID=[your team id]
SLACK_APP_ID=[your app id]
SLACK_APP_SECRET=[your app secret]
SLACK_BOT_NAME=[your bot name]
SLACK_BOT_TOKEN=[your bot token]
SECRET_KEY_BASE=[any string]
RAILS_SERVE_STATIC_FILES=1 # If you use heroku.

BOT_SCRIPT_TIMEOUT=1000 # optional
BOT_STORAGE_MAXIMUM_SIZE=102400 # optional
```

- Slack Team ID
  - https://api.slack.com/methods/auth.test/test

- Application Client ID and Client Secret.
  - https://api.slack.com/applications
  - You should set Redirect URI to `http://{your application host}/auth/slack/callback`.

- BotName and BotToken
  - https://slack.com/services/new/bot

### 3. Install Gems.
```shell
bundle install --path vendor/bundle
```

### 4. Migrate Database.
```shell
bundle exec rake db:migrate RAILS_ENV=production
```

### 5. Run
```shell
bundle exec rails s -e production
```

## Bot API
### Alarm API

> register

```javascript
// Set alarm.
// @param [String]  alarm_name Name of alarm.
// @param [String]  callback   Name of callback.
// @param [Integer] minutes    Minutes.
// @param [Boolean] repeat     Enabled repeat.
api.alarm.register(alarm_name, callback, minutes, repeat)

// Example
api.alarm.register("name", "onAlarm", 1, false)
```

> remove

```javascript
// Remove alarm.
// @param [String]  alarm_name Name of alarm.
api.alarm.remove(alarm_name)

// Example
api.alarm.remove("name")
```

> all

```javascript
// Example
api.alarm.all()
```

> clear

```javascript
// Example
api.alarm.clear()
```

### HTTP API
> GET

```javascript
// Get request.
// @param [String]  url      URL
// @param [Hash]    params   Parameters.
// @param [String]  callback Name of callback function.
api.http.get(url, params, callback)

// Example
api.http.get("http://www.google.co.jp/", {}, "onReceive");
```

> POST

```javascript
// Post request.
// @param [String]  url      URL
// @param [Hash]    params   Parameters.
// @param [String]  callback Name of callback function.
api.http.post(url, params, callback)

// Example
api.http.post("http://www.google.co.jp/", {}, "onReceive");
```

### Slack API
> Talk

```javascript
// Talk
// @param [String] message Message
// @param [Hash] options Message
api.slack.talk(message, options = {})

// Example
api.slack.talk("Hello!")
api.slack.talk("with options", {
  name: 'my_bot',
  icon: ':my_icon:'
})
```

> Talk with icon

```javascript
// Talk with icon
// @param [String] message    Message
// @param [String] icon_emoji Emoji Icon.
api.slack.talk_with_icon(message, icon_emoji)

// Example
api.slack.talk_with_icon("Hello!", "tofu_on_fire")
```

### Storage API
> Set value

```javascript
// Set value.
// @param [String] key   Key
// @param [String] value Value
api.storage[key] = value

// Example
api.storage['name'] = 'alfa'
```

> Get value

```javascript
// Get value.
// @param [String] key   Key
api.storage[key]

// Example
api.storage['name']
```

> Get keys.

```javascript
// Example
api.storage.keys()
```

> Clear all.

```javascript
// Example
api.storage.clear()
```

### Setting API
> Get bot name

```javascript
api.setting.name
```

> Get bot default icon

```javascript
api.setting.icon
```

> Get joined channel

```javascript
api.setting.channel
```

> Get creator name

```javascript
api.setting.user
```

## Bot Webhook
 A bot can hook a request of `http://{yourhost}/bots/{bot_id}/hook`.

### Example
Code
```javascript
function onHook(method, params) {
  slack.api.talk(params['message'])
}
```

Request
```
GET /bots/1/hook?message=hello!
```

In this case, A Bot will say `hello!`.

## Licence
This project is released under the MIT license.
