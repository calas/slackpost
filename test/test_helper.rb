$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'slackpost'
require 'slackpost/exceptions'

require 'minitest/autorun'

def configure_slack_token(token = nil)
  token ||= 'T0...TPS/B4...RP0/reHt........k42UX' # Set here the default token
  Slackpost.configure do |config|
    config.slack_token = token
  end
end

configure_slack_token
