Pod::Spec.new do |s|
  s.name         =  'Snappy'
  s.version      =  '0.1.0'
  s.license      =  'MIT'
  s.summary      =  'A port of snappy-c to Objective-C.'
  s.description  =  'A port of snappy-c to Objective-C.'
  s.homepage     =  'https://github.com/matehat/Snappy-ObjC'
  s.authors      =  'Mathieu D\'Amours'
  
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  
  s.source       =  { :git => 'https://github.com/matehat/Snappy-ObjC.git', :tag => 'v0.1.0', :submodules => true }
  s.source_files =  'snappy-c/*.{h,c}', 'Classes/*.{h,m}'
end
