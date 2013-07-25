module Runscope
  module Configuration
    VALID_OPTIONS_KEYS = [
      :bucket,
      :domains,
      :enabled
    ]

    # By default, use Runscope
    DEFAULT_ENABLED = true

    # By default, send no traffic to Runscope
    DEFAULT_DOMAINS = []

    # By default, don't set a bucket
    DEFAULT_BUCKET = nil

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      Hash[VALID_OPTIONS_KEYS.map {|key| [key, send(key)] }]
    end

    def reset
      self.bucket   = DEFAULT_BUCKET
      self.domains  = DEFAULT_DOMAINS
      self.enabled  = DEFAULT_ENABLED
    end
  end
end
