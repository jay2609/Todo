import 'package:ekstep_assignment/model/signinModel.dart';

abstract class SignInAbs {
  //google sign in method abstraction declaration
  googleSignIn();
  //twitterSignin();
  addDataUser(Map map);
  Stream<userModel?> getUserStreamById();
}
