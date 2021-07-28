import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg-main.jpg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: AutoSizeText(
                "GAME ITEMS PORTFOLIO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 150.0,
                  shadows: [
                    Shadow(
                      blurRadius: 15.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
                maxLines: 1,
              ),
            ),
            Spacer(
              flex: 1,
            ),
             SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () => AuthService.singInWithGoogle(),
            ),*/
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    ));
  }
}
