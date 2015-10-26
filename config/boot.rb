require 'rubygems'
require 'bundler/setup'

module Application

  module Path
    class << self
      attr_accessor :base, :config, :api, :client
    end

    base = File.expand_path '..', File.dirname(__FILE__)
    [ :config, :api, :client ].each do |sym|
      self.send "#{sym}=", "#{base}/#{sym}"
    end

  end

  class << self
    attr_accessor :name, :app
  end

end