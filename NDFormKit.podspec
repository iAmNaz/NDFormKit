Pod::Spec.new do |s|
  s.name         = "NDFormKit"
  s.version      = "0.0.1"
  s.summary      = "NDFormKit Form Validation"
  s.description  = "Tools to make form validation easy"
  s.homepage     = "https://github.com/iAmNaz/NDFormKit"
  s.license      = "Private"
  s.author    = "iAmNaz"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/iAmNaz/NDFormKit", :tag => "#{s.version}"}
  s.source_files  = 'NDFormKit/*.{swift, h}'
  s.requires_arc = true
end