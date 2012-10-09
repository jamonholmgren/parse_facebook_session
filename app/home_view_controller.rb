class HomeViewController < UIViewController
  FB_APP_ID = "163845730420613"
  FB_APP_SECRET = "2819ba5117d8afb0f2b7dddb9e895bb1"

  def viewDidLoad
    super
  end

  def viewWillAppear(animated)
    super
    @fb_connect_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @fb_connect_button.frame = CGRectMake(10, 10, 300, 40)
    @fb_connect_button.setTitle "Connect to Facebook", forState: UIControlStateNormal
    @fb_connect_button.addTarget(self, action: :connect_facebook, forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview @fb_connect_button
  end

  def viewDidAppear(animated)
    super
    display_login unless PFUser.currentUser
  end

  def display_login
    @login = PFLogInViewController.alloc.init
    @login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton
    @login.delegate = self
    @login.signUpController.delegate = self
    self.presentModalViewController(@login, animated:true)
  end

  def connect_facebook
    # PFFacebookUtils logInWithPermissions:permissionsArray block:^
  end
end