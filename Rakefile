# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'parse_facebook_session'
  app.deployment_target = "5.0"

  app.frameworks += %w(AudioToolbox CFNetwork SystemConfiguration MobileCoreServices Security QuartzCore StoreKit AdSupport Social)
  app.weak_frameworks += %w(AdSupport Social)
  
  app.vendor_project('vendor/Parse.framework', :static, :products => ['Parse'], :headers_dir => 'Headers')

  app.development do
    # This entitlement is required during development but must not be used for release.
    app.entitlements['get-task-allow'] = true
  end

  app.identifier = 'com.clearsightstudio.parse_facebook_session'
  app.info_plist['CFBundleURLTypes'] = [ 
    { 'CFBundleURLName' => 'com.clearsightstudio.fb149153618559378', 'CFBundleURLSchemes' => ['fb149153618559378'] } 
  ]

  app.libs += ['/usr/lib/libz.dylib', '/usr/lib/libsqlite3.dylib']
end
