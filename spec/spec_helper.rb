require 'rspec-puppet'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path  = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.before :each do
    Puppet[:autosign] = true # Change autosign from being posix path, which breaks Puppet when we're pretending to be on Windows

    f = self.respond_to?(:facts) ? facts : {} # Work even if you don't specify facts
    Thread.current[:windows?] = lambda { f[:kernel] == "windows" } # Automatically detect whether we're pretending to run on Windows
  end
end

module Puppet
  module Util
    module Platform
      def self.windows?
        # This is where Puppet normally looks for the target OS.
        # It normally returns the *current* OS (i.e., not Windows,
        # if you're not running the specs on Windows)
        !!Thread.current[:windows?].call
      end
    end
  end
end

