import 'package:binder/widgets/binder.dart';
import 'package:binder/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    if (deviceWidth >= 1280.0) {
      return Scaffold(
        body: _BinderIntroStandardWebView(),
      );
    }

    if (deviceWidth >= 800.0) {
      return Scaffold(
        body: _BinderIntroMobileView(),
      );
    }

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Scaffold(
        body: _BinderIntroMobileView(),
      );
    } else {
      return Scaffold(
        body: RotatedBox(
          quarterTurns: 1,
          child: _BinderIntroMobileView(),
        ),
      );
    }
  }
}

class _BinderIntroMobileView extends StatelessWidget {
  const _BinderIntroMobileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg-main.jpg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.65),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: AspectRatio(
            aspectRatio: 8.0 / 5.0,
            child: Stack(
              children: [
                Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 8,
                      child: _Intro(),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                  ],
                ),
                Binder(
                  binderId: 'sorare',
                  showCoverText: false,
                  autoOpen: false,
                ),
              ],
            )),
      ),
    );
  }
}

class _BinderIntroStandardWebView extends StatelessWidget {
  const _BinderIntroStandardWebView({Key key}) : super(key: key);

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
        child: AspectRatio(
          aspectRatio: 13.0 / 5.0,
          child: Row(
            children: [
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 4,
                child: _Intro(),
              ),
              Expanded(
                flex: 7,
                child: Binder(
                  binderId: 'sorare',
                  autoOpen: true,
                  showCoverText: false,
                  showPlayButton: false,
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(flex: 1),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 3,
                child: FittedBox(
                  child: Text(
                    "The fun way to\nshow off your NFTs!",
                    maxLines: 2,
                    style: GoogleFonts.dosis(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: FittedBox(
                  child: Text(
                    "DeedBinder makes it easy to create your\nNFT display and share with your friends\nand community.",
                    maxLines: 3,
                    style: GoogleFonts.dosis(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: FittedBox(
                        child: GoogleButton(),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 4,
                      child: FittedBox(
                        child: FacebookButton(),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
