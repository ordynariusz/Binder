import 'package:binder/widgets/binder.dart';
import 'package:flutter/material.dart';

class BinderScreen extends StatelessWidget {
  static final String id = 'binder_screen';
  final String binderId;
  const BinderScreen({Key key, @required this.binderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    if (deviceWidth >= 800.0) {
      return Scaffold(
        body: _BinderMobileView(
          binderId: binderId,
        ),
      );
    }

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Scaffold(
        body: _BinderMobileView(
          binderId: binderId,
        ),
      );
    } else {
      return Scaffold(
        body: RotatedBox(
          quarterTurns: 1,
          child: _BinderMobileView(
            binderId: binderId,
          ),
        ),
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
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Binder(
          binderId: binderId,
        ),
      ),
    );
  }
}
