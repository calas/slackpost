require 'slackpost/version'

require 'uri'
require 'json'
require 'net/http'
require 'net/https'

# docs
module Slackpost
  class SlackpostError < StandardError; end
  class << self
    def send_simple_msg_to_channel(msg, channel)
      body = { channel: channel,
               link_names: 1,
               text: msg }
      send_slackpost(body)
    end

    def send_attachment_msg_to_channel(msg, channel, att_title, att_value, att_color)
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
      webhook_url = "https://hooks.slack.com/services/#{CONFIG_TOKEN}"
      begin
        uri = URI.parse(webhook_url)
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request = Net::HTTP::Post.new(uri)
          request['Content-Type'] = 'application/json'
          request.body = body.to_json
          http.request(request)
        end
        response
      rescue StandardError => error
        raise SlackpostError error
      end
    end
  end
end
