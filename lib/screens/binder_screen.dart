import 'package:binder/widgets/binder.dart';
import 'package:binder/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BinderScreen extends StatelessWidget {
  static final String id = 'binder_screen';
  final String binderId;
  const BinderScreen({Key key, @required this.binderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    final AppBar appBar = AppBar(
      leading: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('images/icon-small.jpg'),
        ),
      ),
      title: binderId != 'axie'
          ? FittedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffbfbfbf),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Get Your custom DeedBinder!',
                  maxLines: 1,
                  style: GoogleFonts.dosis(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          : Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    child: GoogleButton(),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    child: FacebookButton(),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
      backgroundColor: const Color(0x25bfbfbf),
      elevation: 0.0,
    );

    if (deviceWidth >= 800.0) {
      return Scaffold(
        body: _BinderMobileView(
          binderId: binderId,
        ),
        appBar: appBar,
        extendBodyBehindAppBar: true,
      );
    }

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Scaffold(
        body: _BinderMobileView(
          binderId: binderId,
        ),
        appBar: appBar,
        extendBodyBehindAppBar: true,
      );
    } else {
      return Scaffold(
        body: RotatedBox(
          quarterTurns: 1,
          child: _BinderMobileView(
            binderId: binderId,
          ),
        ),
        appBar: appBar,
        extendBodyBehindAppBar: true,
      );
    }
  }
}

class _BinderMobileView extends StatelessWidget {
  final String binderId;
  const _BinderMobileView({
    Key key,
    @required this.binderId,
  }) : super(key: key);

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
        child: Binder(
          binderId: binderId,
          autoOpen: false,
        ),
      ),
    );
  }
}
