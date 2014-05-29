# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "render_anywhere/version"

Gem::Specification.new do |s|
  s.name        = "render_anywhere"
  s.version     = RenderAnywhere::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Luke Melia"]
  s.email       = ["luke@lukemelia.com"]
  s.homepage    = ""
  s.summary     = %q{Render Rails templates to a string from anywhere.}
  s.description = %q{Out of the box, Rails will render templates in a controller context only. This gem allows for calling "render" from anywhere: models, background jobs, rake tasks, you name it.}
  s.licenses    = ['MIT']

  s.rubyforge_project = "render_anywhere"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('rails', '>= 3.0.7')

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'appraisal'
end
