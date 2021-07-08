import 'package:binder/screens/binder_screen.dart';
import 'package:binder/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeedBinder',
      theme: ThemeData(
          primaryColor: Color(int.parse('0xFF606060')),
          accentColor: Color(int.parse('0xFF43a047')),
          primaryColorLight: Color(int.parse('0xFF606060')),
          primaryColorDark: Color(int.parse('0xFF606060')),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
            ),
          )),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => PreCache(
          screen: HomeScreen(),
        ),
      );
    }

    Uri uri = Uri.parse(settings.name);

    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'binders') {
      String id = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (context) => PreCache(
          screen: BinderScreen(
            binderId: id,
          ),
        ),
      );
    }

    return MaterialPageRoute(
      builder: (context) => PreCache(
        screen: HomeScreen(),
      ),
    );
  }
}

class PreCache extends StatelessWidget {
  final Widget screen;
  const PreCache({
    Key key,
    @required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _preCacheImages() async {
      await precacheImage(
        AssetImage("images/bg-main.jpg"),
        context,
      );

      await precacheImage(
        AssetImage("images/binder_inside.png"),
        context,
      );

      await precacheImage(
        AssetImage("images/paper.png"),
        context,
      );

      await precacheImage(
        AssetImage("images/binder_outside.png"),
        context,
      );

      return Future.delayed(
        Duration(
          milliseconds: 200,
        ),
        () => 'Loaded',
      );
    }

    return FutureBuilder(
      future: _preCacheImages(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasData) {
          return screen;
        } else {
          return Scaffold(
            body: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            ),
          );
        }
      },
    );
  }
}
