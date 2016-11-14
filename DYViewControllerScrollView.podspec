Pod::Spec.new do |s|
s.name = 'DYViewControllerScrollView'
s.version = '1.0.1'
s.license = 'MIT'
s.summary = 'Muti-ViewControllers in ScrollView'
s.homepage = 'https://github.com/jyl485868/DYVCScrollView'
s.authors = { 'dalin' => '897134699@qq.com' }
s.source = { :git => "https://github.com/jyl485868/DYVCScrollView.git", :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'DYViewControllerScrollView/*.{h,m}'
end