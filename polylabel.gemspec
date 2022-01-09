# frozen_string_literal: true

require_relative "lib/polylabel/version"

Gem::Specification.new do |spec|
  spec.name = "polylabel"
  spec.version = Polylabel::VERSION
  spec.authors = ["Frédéric Planté"]
  spec.email = ["frederic.jean.plante@gmail.com"]

  spec.summary = "A ruby port of Mapbox's polylabel algorithm"
  spec.homepage = "https://github.com/fredplante/ruby-polylabel"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fredplante/ruby-polylabel"
  spec.metadata["changelog_uri"] = "https://github.com/fredplante/ruby-polylabel/blob/master/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pqueue", "~> 2.1.0"
end
