pwd = File.expand_path("../", __FILE__)
$LOAD_PATH.unshift(pwd) unless $LOAD_PATH.include?(pwd)
require "cfme-versions"

Gem::Specification.new do |spec|
  spec.name          = "cfme-versions"
  spec.version       = CFME::Versions::version
  spec.authors       = ["ManageIQ Authors"]

  spec.summary       = "Commandline utility and library for viewing versions across CF, CFME, and MIQ"
  spec.description   = "Commandline utility and library for viewing versions across CF, CFME, and MIQ"
  spec.homepage      = "https://github.com/RedHatCloudForms/cfme-versions"
  spec.license       = "Apache-2.0"

  spec.files         = %w[
    cfme-versions
    cfme-versions.rb
    cfme-versions.gemspec
    README.md
    LICENSE.txt
  ]

  spec.bindir        = "."
  spec.executables   = %w[ cfme-versions ]
  spec.require_paths = %w[ . ]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
