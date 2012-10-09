class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    parse_setup
    initial_view

    true
  end

  def parse_setup
    Parse.setApplicationId("M7dOHHwgdko8vzTKoLsErebJMmmPKtrTPaaEVkJC", clientKey: "u7CUnLC5jqUH1uRYCHcw2UCuclovzlb50ocqZBcS")
  end

  def initial_view
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @home_view_controller = HomeViewController.alloc.initWithNibName(nil, bundle:nil)
    self.window.rootViewController = @home_view_controller
    self.window.makeKeyAndVisible
  end
end
