abstract class LoginViewContract{
  void navigateToGetPassword();
  void navigateToSignup();
  void navigateToWrongPassword();
  void navigateToLoadingView();

  void hidePassword();
  void showPassword();
}