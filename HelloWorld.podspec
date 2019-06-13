Pod::Spec.new do |s|
  s.name             = "HelloWorld"
  s.version          = "1.0"
  s.summary          = "Demo"
  s.homepage         = "https://github.com/hello-david/Binarization"
  s.license          = { :type => "MIT"}
  s.author           = { "David" => "hello.david.me@gmail.com" }
  s.source           = { :git => "https://github.com/hello-david/Binarization.git", :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.deployment_target  = '9.0'
  s.default_subspec  = 'Defualt'

  s.subspec 'Defualt' do |sp|
    sp.public_header_files = 'HelloWroldSourceFile/*.{h}'
    sp.source_files  = "HelloWroldSourceFile/*"
  end
end
