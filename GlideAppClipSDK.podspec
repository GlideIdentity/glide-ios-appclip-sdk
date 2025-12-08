Pod::Spec.new do |s|
  s.name              = 'GlideAppClipSDK'
  s.version           = '1.0.0'
  s.summary           = 'A Glide App Clip SDK'
  s.homepage          = 'https://github.com/GlideIdentity/glide-ios-appclip-sdk'
  s.license           = { type: 'MIT' }
  s.author            = { 'Glide' => 'amiravisar89@gmail.com' }
  s.documentation_url = 'https://github.com/GlideIdentity/glide-ios-appclip-sdk/blob/master/README.md'

  s.ios.deployment_target  = '15.0'
  s.swift_version          = '5.9'


  s.source = { git: 'https://github.com/GlideIdentity/glide-ios-appclip-sdk.git',
               tag: s.version }

  s.source_files = 'Sources/**/*.{swift}'

  s.requires_arc = true

end
