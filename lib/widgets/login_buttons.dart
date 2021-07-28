import 'package:binder/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void _showLoginDialog({String type, BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      bool waiting = true;
      bool loggedIn = false;

      return StatefulBuilder(
        builder: (context, setState) {
          if (waiting == true) {
            void onDone(value) {
              setState(
                () {
                  waiting = false;
                  loggedIn = true;
                },
              );
            }

            void onError(value) {
              setState(
                () {
                  waiting = false;
                  loggedIn = false;
                },
              );
            }

            switch (type) {
              case 'Google':
                AuthService.singInWithGoogle().then(
                  onDone,
                  onError: onError,
                );
                break;
              case 'Facebook':
                AuthService.singInWithFacebook().then(
                  onDone,
                  onError: onError,
                );
                break;
              default:
            }
          }

          return AlertDialog(
            title: Text('$type sign up'),
            content: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: waiting == true
                        ? CircularProgressIndicator()
                        : loggedIn == true
                            ? Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      waiting == true
                          ? 'Waiting for $type sign in...'
                          : loggedIn == true
                              ? "Thanks for joining the Deed community!\nWe have added your email to our waiting list. The DeedBinder is in beta phase with limited capacity and we will inform you once you can start using the product.\n\nThanks for your patience."
                              : '$type sign up is not successful. Try once again...',
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      text: "Sign up with Google",
      onPressed: () => _showLoginDialog(
        type: 'Google',
        context: context,
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.FacebookNew,
      text: "Sign up with Facebook",
      onPressed: () => _showLoginDialog(
        type: 'Facebook',
        context: context,
      ),
    );
  }
}
