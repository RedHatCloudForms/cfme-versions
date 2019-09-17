$LOAD_PATH.unshift File.expand_path(File.join("..", ".."), __FILE__)
require "cfme-versions"
require "minitest/autorun"

class CFME::Versions
  # Test helper to stub `exit`
  def self.exit
  end

  # Test helper to clear out the class
  def self.teardown
    @spacer   = nil
    @markdown = nil
  end
end
