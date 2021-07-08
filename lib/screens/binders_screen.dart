import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:better_page_turn/better_page_turn.dart';
import 'package:binder/models/data.dart';
import 'package:binder/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/swipe.dart';

class BindersScreen extends StatelessWidget {
  static final String id = 'binders_screen';
  const BindersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double deviceWidth = MediaQuery.of(context).size.width;
      if (deviceWidth >= 1024.0) {
        return _MyBinderPage();
      }

      return RotatedBox(quarterTurns: 1, child: _MyBinderPageMobile());
    });
  }
}

class _BinderIntroCompactWebView extends StatelessWidget {
  const _BinderIntroCompactWebView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('asdf'),
    );
  }
}

class _BinderIntroStandardWebView extends StatelessWidget {
  const _BinderIntroStandardWebView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('asdf'),
    );
  }
}

class _BinderIntroMobileView extends StatelessWidget {
  const _BinderIntroMobileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('asdf'),
    );
  }
}

class _MyBinderPageMobile extends StatelessWidget {
  const _MyBinderPageMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
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
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Binder(),
          ],
        ),
      ],
    );
  }
}

class _MyBinderPage extends StatelessWidget {
  const _MyBinderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Spacer(
              flex: 2,
            ),
            _Intro(),
            Spacer(
              flex: 1,
            ),
            _Binder(),
            Spacer(
              flex: 2,
            ),
          ]),
        ));
  }
}

class _Intro extends StatelessWidget {
  const _Intro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              20.0,
              10.0,
            ),
            child: AutoSizeText(
              "The fun way to show off your NFTs!",
              maxLines: 3,
              textScaleFactor: 4.0,
              style: GoogleFonts.shareTechMono(
                color: Colors.white,
              ),
              minFontSize: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              0.0,
              15.0,
              20.0,
              25.0,
            ),
            child: AutoSizeText(
              "DeedBinder makes it easy to create your NFT display and share with your friends and community.",
              maxLines: 4,
              textScaleFactor: 1.5,
              style: TextStyle(
                color: Colors.white,
              ),
              minFontSize: 1.0,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () => AuthService.singInWithGoogle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(
                  Buttons.Facebook,
                  text: "Sign up with Facebook",
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(
                  Buttons.Twitter,
                  text: "Sign up with Twitter",
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Binder extends StatelessWidget {
  const _Binder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 18,
      child: AspectRatio(
        aspectRatio: 7.0 / 5.0,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              blurRadius: 10.0,
              spreadRadius: 10.0,
            ),
          ]),
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

    final BinderModel binder = binders[0];

    Widget page = Stack(children: [
      Swipe(
        child: LayoutBuilder(builder: (context, constraints) {
          return HorizontalFlipPageTurn(
            cellSize: Size(constraints.maxWidth, constraints.maxHeight),
            controller: horizontalFlipPageTurnController,
            children: <Widget>[
              for (int i = 0; i < binder.pages.length; i += 2)
                _BinderPages(
                  pageLeft: binder.pages[i],
                  pageRight: binder.pages[i + 1],
                )
            ],
          );
        }),
        onSwipeLeft: () {
          horizontalFlipPageTurnController.animToLeftWidget();
        },
        onSwipeRight: () {
          horizontalFlipPageTurnController.animToRightWidget();
        },
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: () {
                horizontalFlipPageTurnController.animToLeftWidget();
              }),
          Spacer(),
          IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                horizontalFlipPageTurnController.animToRightWidget();
              }),
        ],
      ),
    ]);

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}

class _BinderPages extends StatelessWidget {
  final BinderPageModel pageLeft;
  final BinderPageModel pageRight;
  const _BinderPages({
    Key key,
    @required this.pageLeft,
    @required this.pageRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
            image: DecorationImage(
              image: AssetImage("images/paper.png"),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(5.0, 10.0),
                color: Colors.black,
                blurRadius: 25.0,
                spreadRadius: 25.0,
              ),
            ]),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BinderPage(page: pageLeft),
          VerticalDivider(),
          _BinderPage(page: pageRight),
        ],
      ),
    ]);
  }
}

class _TokenDetails extends StatelessWidget {
  final TokenSlotModel tokenSlot;
  const _TokenDetails({
    Key key,
    @required this.tokenSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
            image: DecorationImage(
              image: AssetImage("images/paper.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 3.0 / 4.0,
                  child: Image(
                    image: AssetImage(tokenSlot.img),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    AutoSizeText(
                      tokenSlot.name,
                      maxLines: 1,
                      textScaleFactor: 5.0,
                      style: GoogleFonts.shareTechMono(
                        color: Colors.black,
                      ),
                      minFontSize: 1.0,
                    ),
                    AutoSizeText(
                      'Collection: ${tokenSlot.collection}',
                      maxLines: 1,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.shareTechMono(
                        color: Colors.black,
                      ),
                      minFontSize: 1.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class _BinderPage extends StatelessWidget {
  final BinderPageModel page;
  const _BinderPage({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _Token(tokenSlot: page.s1),
                _Token(tokenSlot: page.s2),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _Token(tokenSlot: page.s3),
                _Token(tokenSlot: page.s4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Token extends StatelessWidget {
  final TokenSlotModel tokenSlot;
  const _Token({
    Key key,
    @required this.tokenSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        child: AspectRatio(
          aspectRatio: 3.0 / 4.0,
          child: OpenContainer(
            closedColor: Colors.transparent,
            middleColor: Colors.transparent,
            openColor: Colors.transparent,
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (BuildContext context, VoidCallback _) {
              return InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: _TokenCard(
                  tokenSlot: tokenSlot,
                ),
              );
            },
            openBuilder: (BuildContext context, VoidCallback _) {
              return _TokenDetails(
                tokenSlot: tokenSlot,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TokenCard extends StatelessWidget {
  final TokenSlotModel tokenSlot;
  const _TokenCard({
    Key key,
    @required this.tokenSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Image.asset(
        tokenSlot.img,
        fit: BoxFit.contain,
      ),
    );
  }
}
