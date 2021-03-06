# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phpbb3_bb2md/version'

Gem::Specification.new do |spec|
  spec.name          = "phpbb3_bb2md"
  spec.version       = PHPBB3_BB2MD::VERSION
  spec.authors       = ["marguerite"]
  spec.email         = ["i@marguerite.su"]

  spec.summary       = %q{Preprocess phpbb3 bbcode posts to discourse markdown}
  spec.description   = %q{Preprocess phpbb3 bbcode posts to discourse markdown right in phpbb3's mysql database}
  spec.homepage      = "http://github.com/openSUSE-zh/discourse-phpbb3-preprocess-posts"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
	  spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mysql2", "~> 0.4"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
