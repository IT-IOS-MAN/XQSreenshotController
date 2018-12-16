Pod::Spec.new do |s|
s.name = 'XQSreenshotController'
s.version = '0.0.1'
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary = '多级菜单'
s.homepage = 'https://github.com/weakGG/XQSreenshotController'
s.authors = { 'WeakGG' => '917709989@qq.com' }
s.source = { :git => "https://github.com/weakGG/XQSreenshotController.git", :tag => "0.0.1"}
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = "XQSreenshotController/XQScreenshot/*.{h,m}"
s.frameworks = 'UIKit'
end
