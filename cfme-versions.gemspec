lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cfme-versions"

Gem::Specification.new do |spec|
  spec.name          = "cfme-versions"
  spec.version       = CFME::Versions.version
  spec.authors       = ["ManageIQ Authors"]

  spec.summary       = "Commandline utility and library for viewing versions across CF, CFME, and MIQ"
  spec.description   = "Commandline utility and library for viewing versions across CF, CFME, and MIQ"
  spec.homepage      = "https://github.com/RedHatCloudForms/cfme-versions"
  spec.license       = "Apache-2.0"

  spec.files         = %w[
    exe/cfme-versions
    lib/cfme-versions.rb
    cfme-versions.gemspec
    LICENSE.txt
    README.md
  ]
  spec.bindir        = "exe"
  spec.executables   = ["cfme-versions"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
