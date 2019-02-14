module Slackpost
  # Holds gem configuration
  class Configuration
    attr_accessor :slack_token

    def initialize
      @slack_token = :slack_token
    end
  end
end
