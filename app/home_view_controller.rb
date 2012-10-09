class HomeViewController < UIViewController
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

    @logout_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @logout_button.frame = CGRectMake(10, 80, 300, 40)
    @logout_button.setTitle "Log Out", forState: UIControlStateNormal
    @logout_button.addTarget(self, action: :log_out, forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview @logout_button

    @crash_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @crash_button.frame = CGRectMake(10, 160, 300, 40)
    @crash_button.setTitle "Crash it", forState: UIControlStateNormal
    @crash_button.addTarget(self, action: :crash_it, forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview @crash_button
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

  def log_out
    PFUser.logOut
    display_login
  end

  def crash_it
    params = NSMutableDictionary.dictionaryWithObjectsAndKeys "SELECT uid,first_name,middle_name,last_name,name,pic_small,pic_big,birthday,birthday_date FROM user WHERE uid IN (SELECT uid1 FROM friend WHERE uid2=me())", "query", nil
    request = PFFacebookUtils.facebook.requestWithMethodName "fql.query", andParams:params,
                       andHttpMethod:"POST",
                         andDelegate:self
  end

  def requestLoading(request)
  end
  def request(request, didReceiveResponse: response)
  end
  def request(request, didLoad:result)
    $stderr.puts result
  end

  def logInViewController(logIn, didLogInUser:user)
    @login.dismissModalViewControllerAnimated(true)
  end

  def connect_facebook
    if PFFacebookUtils.isLinkedWithUser PFUser.currentUser
      link_user
    else
      unlink_user
    end
  end

  def link_user
    PFFacebookUtils.unlinkUserInBackground PFUser.currentUser, block: lambda { |success, error|
      if success
        alert = UIAlertView.alloc.initWithTitle "Facebook",
          message: "Unlinked!",
          delegate: nil,
          cancelButtonTitle:"OK",
          otherButtonTitles:nil
        alert.show
      else
        alert = UIAlertView.alloc.initWithTitle "Facebook",
          message: "Unlink failed!",
          delegate: nil,
          cancelButtonTitle:"DARN",
          otherButtonTitles:nil
        alert.show
      end      
    }
  end

  def unlink_user
    PFFacebookUtils.linkUser PFUser.currentUser, permissions: ["friends_birthday"], block: lambda { |success, error|
      if success
        alert = UIAlertView.alloc.initWithTitle "Facebook",
          message: "Linked!",
          delegate: nil,
          cancelButtonTitle:"OK",
          otherButtonTitles:nil
        alert.show
      else
        alert = UIAlertView.alloc.initWithTitle "Facebook",
          message: "Link failed!",
          delegate: nil,
          cancelButtonTitle:"DARN",
          otherButtonTitles:nil
        alert.show
      end
    }
  end
end