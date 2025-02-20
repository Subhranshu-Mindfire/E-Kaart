# -*- encoding: utf-8 -*-
# stub: ajax-datatables-rails 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ajax-datatables-rails".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/jbox-web/ajax-datatables-rails/issues", "changelog_uri" => "https://github.com/jbox-web/ajax-datatables-rails/blob/master/CHANGELOG.md", "homepage_uri" => "https://github.com/jbox-web/ajax-datatables-rails", "source_code_uri" => "https://github.com/jbox-web/ajax-datatables-rails" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Joel Quenneville".freeze, "Antonio Antillon".freeze]
  s.date = "2024-04-08"
  s.description = "A wrapper around datatable's ajax methods that allow synchronization with server-side pagination in a rails app".freeze
  s.email = ["joel.quenneville@collegeplus.org".freeze, "antillas21@gmail.com".freeze]
  s.homepage = "https://github.com/jbox-web/ajax-datatables-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "A gem that simplifies using datatables and hundreds of records via ajax".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 6.0"])
    s.add_runtime_dependency(%q<zeitwerk>.freeze, [">= 0"])
    s.add_development_dependency(%q<activerecord-oracle_enhanced-adapter>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<combustion>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<faker>.freeze, [">= 0"])
    s.add_development_dependency(%q<generator_spec>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<puma>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-retry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.4.0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 6.0"])
    s.add_dependency(%q<zeitwerk>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord-oracle_enhanced-adapter>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<combustion>.freeze, ["~> 1.3"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<generator_spec>.freeze, [">= 0"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<puma>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-retry>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.4.0"])
  end
end
