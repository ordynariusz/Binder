import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'dart:js_util';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static UserCredential userCredentials;
  static String ethAddress;

  static Future<void> singInWithGoogle() async {
    GoogleAuthProvider provider = GoogleAuthProvider();
    userCredentials = await _auth.signInWithPopup(provider);
    return userCredentials.user.email;
  }

  static Future<void> singInWithFacebook() async {
    FacebookAuthProvider provider = FacebookAuthProvider();
    userCredentials = await _auth.signInWithPopup(provider);
    return userCredentials.user.email;
  }

  static Future<String> signInWithEthereum() async {
    if (ethereum == null) {
      throw "No ethereum wallet found. Install Metamask or similar";
    }
    var accounts = await promiseToFuture(
        ethereum.request(RequestParams(method: 'eth_requestAccounts')));
    ethAddress = ethereum.selectedAddress;
    return ethAddress;
  }

  static void logout() {
    _auth.signOut();
  }
}
