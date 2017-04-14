Pod::Spec.new do |s|
  s.name             = 'ZKPayMediator'
  s.version          = '0.1.1'
  s.summary          = 'A short description of ZKPayMediator.'
  s.homepage         = 'https://github.com/kaiser143/ZKPayMediator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kaiser' => 'deyang143@126.com' }
  s.source           = { :git => 'https://github.com/kaiser143/ZKPayMediator.git', :tag => s.version.to_s }
  s.requires_arc     = true
  s.ios.deployment_target = '7.0'

  s.subspec 'Base' do |ss|
  	ss.source_files = 'ZKPayMediator/Classes/*.{h,m}'
  	ss.public_header_files = 'ZKPayMediator/Classes/*.h'
    ss.ios.library = 'c++', 'z'
  	ss.framework = 'CoreTelephony', 'SystemConfiguration', 'CFNetwork'
  	ss.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end

  s.subspec 'AliPay' do |ss|
    ss.source_files = 'ZKPayMediator/Classes/AliPay/*.{h,m}'
    ss.public_header_files = 'ZKPayMediator/Classes/AliPay/*.h'
    ss.ios.vendored_frameworks = 'ZKPayMediator/Classes/AliPay/AlipaySDK.framework'
    ss.resource = 'ZKPayMediator/Classes/AliPay/AlipaySDK.bundle'
    ss.frameworks = 'CoreMotion', 'CoreGraphics', 'CoreText', 'QuartzCore'
    ss.dependency 'ZKPayMediator/Base'
  end

  s.subspec 'WXPay' do |ss|
    ss.source_files = 'ZKPayMediator/Classes/WXPay/*.{h,m}'
    ss.public_header_files = 'ZKPayMediator/Classes/WXPay/*.h'
    ss.vendored_libraries = 'ZKPayMediator/Classes/WXPay/*.a'
    ss.ios.library = 'sqlite3.0'
    ss.dependency 'ZKPayMediator/Base'
  end
end
