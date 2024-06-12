# -*- encoding: utf-8 -*-
# stub: tmuxinator 3.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "tmuxinator".freeze
  s.version = "3.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.23".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Allen Bargi".freeze, "Christopher Chow".freeze]
  s.date = "2024-05-23"
  s.description = "Create and manage complex tmux sessions easily.".freeze
  s.email = ["allen.bargi@gmail.com".freeze, "chris@chowie.net".freeze]
  s.executables = ["tmuxinator".freeze]
  s.files = ["bin/tmuxinator".freeze]
  s.homepage = "https://github.com/tmuxinator/tmuxinator".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\n    __________________________________________________________\n    ..........................................................\n\n    Thank you for installing tmuxinator.\n\n    Make sure that you've set these variables in your ENV:\n\n      $EDITOR, $SHELL\n\n    You can run `tmuxinator doctor` to make sure everything is set.\n    Happy tmuxing with tmuxinator!\n\n    ..........................................................\n    __________________________________________________________\n  ".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.7".freeze)
  s.rubygems_version = "3.3.25".freeze
  s.summary = "Create and manage complex tmux sessions easily.".freeze

  s.installed_by_version = "3.3.25" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<erubi>.freeze, ["~> 1.7"])
    s.add_runtime_dependency(%q<thor>.freeze, ["~> 1.3.0"])
    s.add_runtime_dependency(%q<xdg>.freeze, ["~> 2.2", ">= 2.2.5"])
    s.add_development_dependency(%q<activesupport>.freeze, ["< 5.0.0"])
    s.add_development_dependency(%q<awesome_print>.freeze, ["~> 1.2"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.3"])
    s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8"])
    s.add_development_dependency(%q<factory_bot>.freeze, ["~> 4.8"])
    s.add_development_dependency(%q<pry>.freeze, ["~> 0.10"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.3"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.61.1"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16"])
    s.add_development_dependency(%q<unicode-display_width>.freeze, ["~> 1.3"])
  else
    s.add_dependency(%q<erubi>.freeze, ["~> 1.7"])
    s.add_dependency(%q<thor>.freeze, ["~> 1.3.0"])
    s.add_dependency(%q<xdg>.freeze, ["~> 2.2", ">= 2.2.5"])
    s.add_dependency(%q<activesupport>.freeze, ["< 5.0.0"])
    s.add_dependency(%q<awesome_print>.freeze, ["~> 1.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.3"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8"])
    s.add_dependency(%q<factory_bot>.freeze, ["~> 4.8"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.61.1"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16"])
    s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.3"])
  end
end
