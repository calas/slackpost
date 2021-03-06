require 'slackpost/version'
require 'slackpost/configuration'
require 'slackpost/exceptions'

require 'uri'
require 'json'
require 'net/http'
require 'net/https'

# docs
module Slackpost
  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end

    def simple_msg_to_channel(msg, channel)
      body = { channel: channel,
               link_names: 1,
               text: msg }
      send_slackpost(body)
    end

    def attachment_msg_to_channel(msg, channel, att_title, att_value, att_color)
      body = { channel: channel,
               link_names: 1,
               text: msg,
               attachments: [{ fallback: "#{att_title} #{att_value}",
                               color: att_color,
                               fields: [{ title: att_title,
                                          value: att_value }] }] }
      send_slackpost(body)
    end

    def send_slackpost(body)
      uri = URI.parse("https://hooks.slack.com/services/#{config.slack_token}")
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Post.new(uri)
        request['Content-Type'] = 'application/json'
        request.body = body.to_json
        http.request(request)
      end
      raise SlackpostError if response.code != '200'

      response
    end
  end
end
