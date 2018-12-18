Pod::Spec.new do |s|
s.name = 'XQSreenshotController'
s.version = '0.0.3'
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary = '头像选择器'
s.homepage = 'https://github.com/weakGG/XQSreenshotController'
s.authors = { 'WeakGG' => '917709989@qq.com' }
s.source = { :git => "https://github.com/weakGG/XQSreenshotController.git", :tag => "0.0.2"}
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = "XQSreenshotController/XQScreenshot/*.{h,m}"
s.resource = "XQSreenshotController/XQScreenshot/Resources/XQScreenshot.bundle"
s.frameworks = 'UIKit'
end
