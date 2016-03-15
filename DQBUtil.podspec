Pod::Spec.new do |s|
s.name = 'DQBUtil'
s.version = '1.0.1'
s.license = 'MIT'
s.summary = 'some utility methods apply for iOS apps.'
s.homepage = 'https://github.com/Jackson-Jack/DQBUtil'
s.authors = { 'DQB' => 'dqb1690@163.com' }
s.source = { :git => 'https://github.com/Jackson-Jack/DQBUtil.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'DQBUtil/*.{h,m}'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit' 
end
