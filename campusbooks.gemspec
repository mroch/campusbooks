# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{campusbooks}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marshall Roch"]
  s.date = %q{2009-08-27}
  s.description = %q{A Ruby library for accessing the CampusBooks.com API}
  s.email = %q{marshall@mroch.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/campusbooks", "lib/campusbooks/base.rb", "lib/campusbooks/book.rb", "lib/campusbooks/offer.rb", "lib/campusbooks.rb", "lib/isbn", "lib/isbn/LICENCE", "lib/isbn/README", "lib/isbn/tools.rb", "test/base_test.rb", "test/book_test.rb", "test/offer_test.rb", "test/test_helper.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mroch/campusbooks}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{CampusBooks API for Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end
