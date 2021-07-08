import 'package:animations/animations.dart';
import 'package:better_page_turn/better_page_turn.dart';
import 'package:flutter/material.dart';
import 'package:binder/services/auth_service.dart';
import 'package:binder/widgets/error_indicator.dart';
import 'package:binder/widgets/wait_indicator.dart';

class MyBinderScreen extends StatelessWidget {
  static final String id = 'my_binder_screen';
  const MyBinderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<void> _logIn = AuthService.singInWithGoogle();
    return FutureBuilder<void>(
        future: _logIn,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return WaitIndicator(
              text: 'Awaiting for Google Login...',
            );
          } else if (snapshot.hasData) {
            return _MyBinderPage();
          } else {
            return ErrorIndicator(
              text: 'Error during Google Login...',
              onPressed: () {},
            );
          }
        });
  }
}

class _MyBinderPage extends StatelessWidget {
  const _MyBinderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String email = AuthService.userCredentials.user.email;

    return Container(
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
        child: Container(
          width: 900.0,
          height: 700.0,
          child: Navigator(
            onGenerateRoute: _onGenerateRoute,
          ),
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    final HorizontalFlipPageTurnController horizontalFlipPageTurnController =
        HorizontalFlipPageTurnController();

    Widget page = Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return HorizontalFlipPageTurn(
          cellSize: Size(constraints.maxWidth, 700),
          controller: horizontalFlipPageTurnController,
          children: <Widget>[
            for (var i = 0; i < 10; i += 2) _BinderPages(page: i)
          ],
        );
      }),
      floatingActionButton: Row(
        children: [
          Spacer(
            flex: 7,
          ),
          FloatingActionButton(
            child: Icon(Icons.navigate_before),
            onPressed: () {
              horizontalFlipPageTurnController.animToLeftWidget();
            },
          ),
          Spacer(
            flex: 1,
          ),
          FloatingActionButton(
            child: Icon(Icons.navigate_next),
            onPressed: () {
              horizontalFlipPageTurnController.animToRightWidget();
            },
          ),
          Spacer(
            flex: 7,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}

class _BinderPages extends StatelessWidget {
  final int page;
  const _BinderPages({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BinderPage(page: page),
          VerticalDivider(),
          _BinderPage(page: page + 1),
        ],
      ),
    );
  }
}

class _TokenDetails extends StatelessWidget {
  final int page;
  final int slot;
  const _TokenDetails({
    Key key,
    @required this.page,
    @required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 400,
              height: 600,
              child: Image.asset(
                "images/token.jpg",
                fit: BoxFit.cover,
              ),
            ),
            VerticalDivider(),
            Container(
              width: 400,
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Token Name'),
                  Text('Collection'),
                  Text('$page $slot'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BinderPage extends StatelessWidget {
  final int page;
  const _BinderPage({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < 2; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _Token(
                  page: page,
                  slot: i,
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 2; i < 4; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _Token(
                  page: page,
                  slot: i,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Token extends StatelessWidget {
  final int page;
  final int slot;
  const _Token({
    Key key,
    @required this.page,
    @required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (BuildContext context, VoidCallback _) {
        return _TokenCard(page: page, slot: slot);
      },
      openBuilder: (BuildContext context, VoidCallback _) {
        return _TokenDetails(page: page, slot: slot);
      },
    );
  }
}

class _TokenCard extends StatelessWidget {
  final int page;
  final int slot;
  const _TokenCard({
    Key key,
    @required this.page,
    @required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 300.0,
      child: Card(
        child: Column(
          children: [
            Image.asset(
              "images/token.jpg",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
