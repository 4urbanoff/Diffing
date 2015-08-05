Gem::Specification.new do |s|

  s.name                  = 'diffing'
  s.version               = '0.2.1'
  s.author                = 'Denis Churbanov'
  s.email                 = '4urbanoff@gmail.com'
  s.description           = 'Diffing of two strings'
  s.summary               = 'Gem for calculating two strings difference'
  s.homepage              = 'https://github.com/4urbanoff/Diffing'
  s.license               = 'MIT'
  s.files                 = Dir[ 'lib/**/*' ] + [ 'LICENSE.txt', 'Rakefile', 'Gemfile', 'README.md' ]
  s.required_ruby_version = '>= 2.0.0'
  s.require_path          = 'lib'
  s.has_rdoc              = false
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

end
