class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    parse_setup
    initial_view

    true
  end

  def parse_setup
    Parse.setApplicationId("EnenIJ4D3gl00sKCIQbUZLKn5TSaThoQrTw3m0j7", clientKey: "AcrSTHBx8ywRJ1BXMnChZzs1iDyCigpMip6dT3pI")
    PFFacebookUtils.initializeWithApplicationId("163845730420613")
  end

  def initial_view
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @home_view_controller = HomeViewController.alloc.initWithNibName(nil, bundle:nil)
    self.window.rootViewController = @home_view_controller
    self.window.makeKeyAndVisible
  end

  def application(application, handleOpenURL:url)
    PFFacebookUtils.handleOpenURL url
  end

  def application(application, openURL:url, sourceApplication: sourceApplication, annotation: annotation)
    PFFacebookUtils.handleOpenURL url
  end
end
