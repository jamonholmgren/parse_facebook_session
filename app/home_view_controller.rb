class HomeViewController < UIViewController
  def viewDidLoad
  end

  def viewWillAppear(animated)
    display_login unless PFUser.currentUser
  end

  def display_login
    @login = PFLogInViewController.alloc.init
    @login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton
    @login.delegate = self
    @login.signUpController.delegate = self
    self.presentModalViewController(@login, animated:true)
  end
end