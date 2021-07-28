import 'package:binder/models/BinderState.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:better_page_turn/horizontal_flip_page_turn.dart';
import 'package:binder/models/data.dart';
import 'package:flip/flip.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:universal_io/io.dart' as IO;
import 'package:url_launcher/url_launcher.dart';
import 'package:path_drawing/path_drawing.dart';

final FlipController flipController = FlipController();
final HorizontalFlipPageTurnController horizontalFlipPageTurnController =
    HorizontalFlipPageTurnController();

class Binder extends StatelessWidget {
  final String binderId;
  final bool autoOpen;
  final bool showCoverText;
  final bool showPlayButton;

  const Binder({
    Key key,
    @required this.binderId,
    @required this.autoOpen,
    this.showCoverText = true,
    this.showPlayButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(
          milliseconds: 200,
        ), () {
      flipController.isFront = true;
    });
    return _BinderOutside(
      autoOpen: autoOpen,
      binder: binders[binderId],
      showCoverText: showCoverText,
      showPlayButton: showPlayButton,
    );
  }
}

class _BinderOutside extends StatelessWidget {
  final BinderModel binder;
  final bool autoOpen;
  final bool showCoverText;
  final bool showPlayButton;
  const _BinderOutside({
    Key key,
    @required this.binder,
    this.autoOpen,
    this.showCoverText,
    this.showPlayButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 8.0 / 5.0,
      child: Flip(
        controller: flipController,
        firstChild: _BinderStart(
          binder: binder,
          autoOpen: autoOpen,
          showCoverText: showCoverText,
          showPlayButton: showPlayButton,
        ),
        secondChild: _BinderOpen(
          binder: binder,
          showCoverText: showCoverText,
        ),
        flipDuration: Duration(milliseconds: 600),
      ),
    );
  }
}

class _BinderStart extends StatelessWidget {
  final BinderModel binder;
  final bool autoOpen;
  final bool showCoverText;
  final bool showPlayButton;

  const _BinderStart({
    Key key,
    @required this.binder,
    this.autoOpen,
    this.showCoverText,
    this.showPlayButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (autoOpen == true)
      Future.delayed(
          Duration(
            milliseconds: 2000,
          ), () {
        flipController.isFront = false;
      });

    return AspectRatio(
      aspectRatio: 7.0 / 5.0,
      child: Stack(children: [
        Row(
          children: [
            Spacer(),
            Expanded(
              child: AspectRatio(
                aspectRatio: 5.0 / 7.0,
                child: _BinderCover(
                  binder: binder,
                  autoOpen: autoOpen,
                  showCoverText: showCoverText,
                ),
              ),
            ),
          ],
        ),
        showPlayButton == true || true
            ? Column(
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Spacer(
                          flex: 11,
                        ),
                        Expanded(
                          flex: 2,
                          child: FittedBox(
                            child: ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: Ink(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    iconSize: 100.0,
                                    onPressed: () {
                                      flipController.isFront = false;
                                    },
                                    hoverColor: const Color(0x25bfbfbf),
                                    icon: Icon(
                                      Icons.play_circle,
                                      color: const Color(0xffbfbfbf),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              )
            : Text(''),
      ]),
    );
  }
}

class _BinderCover extends StatelessWidget {
  final BinderModel binder;
  final bool autoOpen;
  final bool showCoverText;
  const _BinderCover({
    Key key,
    @required this.binder,
    this.autoOpen,
    this.showCoverText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(binder.cover),
              fit: BoxFit.cover,
            ),
          ),
        ),
        showCoverText == true
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(
                      flex: 4,
                    ),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        child: Text(
                          '${binder.title}',
                          maxLines: 2,
                          style: GoogleFonts.dosis(
                            color: const Color(0xffbfbfbf),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: Text(
                          'Owner: ${binder.owner}',
                          maxLines: 1,
                          style: GoogleFonts.dosis(
                            color: const Color(0xffbfbfbf),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(
                      flex: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: FittedBox(
                        child: Text(
                          'My NFT\nCollection',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dosis(
                            color: const Color(0xffbfbfbf),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 13,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

class _BinderOpen extends StatelessWidget {
  final BinderModel binder;
  final bool showCoverText;
  const _BinderOpen({Key key, @required this.binder, this.showCoverText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 8.0 / 5.0,
      child: ChangeNotifierProvider(
        create: (context) => BinderState(),
        child: Stack(
          children: [
            Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 14,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/binder_inside.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Spacer(flex: 1),
                            Expanded(
                              flex: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Spacer(flex: 1),
                                  Expanded(
                                    flex: 14,
                                    child: _BinderInside(
                                      binder: binder,
                                    ),
                                  ),
                                  Spacer(flex: 1),
                                ],
                              ),
                            ),
                            Spacer(flex: 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Consumer<BinderState>(
              builder: (context, binderState, child) {
                return _ShellControls(
                  binderModel: binder,
                  arrowsEnabled: !binderState.isTokenOpen,
                  shareButtonVisible: showCoverText,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ShellControls extends StatefulWidget {
  final BinderModel binderModel;
  final bool arrowsEnabled;
  final bool shareButtonVisible;

  _ShellControls({
    Key key,
    @required this.binderModel,
    @required this.arrowsEnabled,
    this.shareButtonVisible = true,
  }) : super(key: key);

  @override
  __ShellControlsState createState() => __ShellControlsState();
}

class __ShellControlsState extends State<_ShellControls> {
  int _postiion = 1;

  void goToNextPage() {
    horizontalFlipPageTurnController.animToRightWidget();
    setState(() {
      _postiion++;
    });
  }

  void goToPreviousPage() {
    if (_postiion == 1) {
      flipController.isFront = true;
    } else {
      horizontalFlipPageTurnController.animToLeftWidget();
      setState(() {
        _postiion--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FittedBox(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                color: Colors.transparent,
                child: IconButton(
                    icon: const Icon(
                      Icons.navigate_before,
                    ),
                    color: Colors.white,
                    onPressed: widget.arrowsEnabled ? goToPreviousPage : null),
              ),
            ),
          ),
        ),
        Spacer(flex: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(),
                    widget.shareButtonVisible == true
                        ? Expanded(
                            flex: 2,
                            child: FittedBox(
                              child: IO.Platform.isAndroid || IO.Platform.isIOS
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Share.share(
                                            'The fun way to show off your NFTs! https://binder-29325.web.app',
                                            subject: 'DeedBinder');
                                      },
                                    )
                                  : PopupMenuButton(
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text("Facebook"),
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: Text("Mail"),
                                          value: 3,
                                        )
                                      ],
                                      onSelected: (value) {
                                        switch (value) {
                                          case 1:
                                            launch(
                                              "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fbinder-29325.web.app%2F&amp;src=sdkpreparse",
                                            );
                                            break;
                                          case 2:
                                            break;
                                          case 3:
                                            Share.share(
                                                'The fun way to show off your NFTs! https://binder-29325.web.app',
                                                subject: 'DeedBinder');
                                            break;
                                          default:
                                        }
                                      },
                                    ),
                            ),
                          )
                        : Spacer(
                            flex: 2,
                          ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FittedBox(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(
                          Icons.navigate_next,
                        ),
                        color: Colors.white,
                        onPressed: widget.arrowsEnabled &&
                                widget.binderModel.pages.length / 2 > _postiion
                            ? goToNextPage
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BinderInside extends StatelessWidget {
  final BinderModel binder;
  const _BinderInside({
    Key key,
    @required this.binder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    Widget page = LayoutBuilder(builder: (context, constraints) {
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
    });

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 10,
          child: _BinderPage(
            page: pageLeft,
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: _BinderPage(
            page: pageRight,
          ),
        ),
      ],
    );
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
    final BinderState binderState = Provider.of<BinderState>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () {
        binderState.closeTokenDetails();
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
                  child: FadeInImage(
                    image: AssetImage(tokenSlot.img),
                    fit: BoxFit.contain,
                    placeholder: MemoryImage(kTransparentImage),
                  ),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: AspectRatio(
                      aspectRatio: 3.0 / 4.0,
                      child: Container(
                        padding: EdgeInsets.all(
                          15.0,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xffF0E5C9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            border: Border.all(
                              color: Colors.black,
                              width: 3.0,
                            )),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: FittedBox(
                                child: Text(
                                  tokenSlot.name,
                                  maxLines: 1,
                                  style: GoogleFonts.dosis(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                child: Text(
                                  'Collection: ${tokenSlot.collection}',
                                  maxLines: 1,
                                  style: GoogleFonts.dosis(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 15,
                              child: tokenSlot.attributes != null
                                  ? Scrollbar(
                                      isAlwaysShown: true,
                                      child: ListView(
                                        children: [
                                          for (int i = 0;
                                              i < tokenSlot.attributes.length;
                                              i++)
                                            ListTile(
                                              visualDensity: VisualDensity(
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              title: Text(
                                                tokenSlot.attributes[i].name,
                                                style: GoogleFonts.dosis(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Text(
                                                tokenSlot.attributes[i].value,
                                                textScaleFactor: 1.35,
                                                style: GoogleFonts.dosis(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  : Text(""),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        image: DecorationImage(
          image: AssetImage("images/paper.png"),
          fit: BoxFit.cover,
        ),
      ),
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
    final BinderState binderState = Provider.of<BinderState>(
      context,
      listen: false,
    );

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        child: AspectRatio(
          aspectRatio: 3.0 / 4.0,
          child: HoverWidget(
            hoverChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OpenContainer(
                closedColor: Colors.transparent,
                middleColor: Colors.transparent,
                openColor: Colors.transparent,
                transitionType: ContainerTransitionType.fadeThrough,
                closedBuilder: (BuildContext context, VoidCallback cb) {
                  return InkWell(
                    onTap: () {
                      binderState.openTokenDetails();
                      cb();
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: tokenSlot.collection == 'Axie Infinity'
                        ? _AxieTokenCard(
                            tokenSlot: tokenSlot,
                          )
                        : _TokenCard(
                            tokenSlot: tokenSlot,
                          ),
                  );
                },
                openBuilder: (BuildContext context, VoidCallback _) {
                  return tokenSlot.collection == 'Axie Infinity'
                      ? _AxieTokenDetails(
                          tokenSlot: tokenSlot,
                        )
                      : _TokenDetails(
                          tokenSlot: tokenSlot,
                        );
                },
              ),
            ),
            onHover: (event) {},
            child: OpenContainer(
              closedColor: Colors.transparent,
              middleColor: Colors.transparent,
              openColor: Colors.transparent,
              transitionType: ContainerTransitionType.fadeThrough,
              closedBuilder: (BuildContext context, VoidCallback cb) {
                return InkWell(
                  onTap: () {
                    binderState.openTokenDetails();
                    cb();
                  },
                  mouseCursor: SystemMouseCursors.click,
                  child: tokenSlot.collection == 'Axie Infinity'
                      ? _AxieTokenCard(
                          tokenSlot: tokenSlot,
                        )
                      : _TokenCard(
                          tokenSlot: tokenSlot,
                        ),
                );
              },
              openBuilder: (BuildContext context, VoidCallback _) {
                return tokenSlot.collection == 'Axie Infinity'
                    ? _AxieTokenDetails(
                        tokenSlot: tokenSlot,
                      )
                    : _TokenDetails(
                        tokenSlot: tokenSlot,
                      );
              },
            ),
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
      child: FadeInImage(
        image: AssetImage(tokenSlot.img),
        fit: BoxFit.contain,
        placeholder: MemoryImage(kTransparentImage),
      ),
    );
  }
}

final Path healthPath = parseSvgPathData(
    'M8 12.394s-4.98-1.626-4.98-5.152A2.72 2.72 0 018 5.73a2.72 2.72 0 014.98 1.512c0 3.526-4.98 5.152-4.98 5.152');
final Path speedPath = parseSvgPathData(
    'M9.488 6.85h.96c.16 0 .253.184.157.312L6.56 12.666c-.126.159-.381.047-.349-.154l.697-3.96a.195.195 0 00-.194-.23h-.808a.198.198 0 01-.194-.231l.958-5.009a.197.197 0 01.193-.16h3.586c.135 0 .23.134.183.262L9.305 6.581a.197.197 0 00.183.268');
final Path skillPath = parseSvgPathData(
    'M11.374 9.463c-.093.308-.15 3.015-.394 3.205-.246.19-2.677-.59-2.98-.59-.303 0-2.734.78-2.98.59-.245-.19-.302-2.897-.395-3.205-.093-.307-1.54-2.533-1.445-2.84.093-.307 2.488-1.201 2.735-1.39.244-.19 1.782-2.346 2.085-2.346.302 0 1.84 2.155 2.085 2.345.246.19 2.642 1.084 2.735 1.391.095.307-1.352 2.533-1.446 2.84');
final Path moralePath = parseSvgPathData(
    'M11.177 9.139c0 .132-.009.261-.023.39-.176 1.959-1.5 3.263-3.336 3.263-1.781 0-3.017-1.232-3.33-3.106a3.407 3.407 0 01-.046-.547l.012-.229c.043-.771.39-1.577.909-2.087l.363-.358.024.509c.012.236.128.458.337.642.107.094.365.195.676.195.161 0 .314-.028.442-.08a.596.596 0 00.397-.532c.023-.325-.107-.486-.272-.69-.184-.226-.413-.507-.534-1.13-.15-.778.287-1.514 1.23-2.073l.482-.285-.146.54a.995.995 0 00-.032.213c-.02.567.444 1.273 1.417 2.157 1.242 1.13 1.419 2.14 1.423 2.98l.007.228z');

class _AxieTokenCard extends StatelessWidget {
  final TokenSlotModel tokenSlot;
  const _AxieTokenCard({
    Key key,
    @required this.tokenSlot,
  }) : super(key: key);

  CustomPainter getIconForName(String name) {
    switch (name) {
      case 'Health':
        return FilledPathPainter(
          path: healthPath,
          color: Color(0xff6cc000),
        );
        break;
      case 'Speed':
        return FilledPathPainter(
          path: speedPath,
          color: Color(0xffffb812),
        );
        break;
      case 'Skill':
        return FilledPathPainter(
          path: skillPath,
          color: Color(0xff8d65ff),
        );
        break;
      case 'Morale':
        return FilledPathPainter(
          path: moralePath,
          color: Color(0xffff5341),
        );
        break;
      default:
        return FilledPathPainter(
          path: healthPath,
          color: Color(0xff6cc000),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AspectRatio(
          aspectRatio: 3.0 / 4.0,
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xff282b39),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: FadeInImage(
                        image: AssetImage(tokenSlot.img),
                        placeholder: MemoryImage(kTransparentImage),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: FittedBox(
                                child: Text(
                                  tokenSlot.name,
                                  style: GoogleFonts.dosis(
                                    color: Colors.orange[300],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            for (int i = 0;
                                i < tokenSlot.attributes.length;
                                i++)
                              if (tokenSlot.attributes[i].name != 'Class')
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          child: CustomPaint(
                                            size: Size.square(16.0),
                                            painter: getIconForName(
                                                tokenSlot.attributes[i].name),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          child: Text(
                                            tokenSlot.attributes[i].value == ""
                                                ? "00"
                                                : tokenSlot.attributes[i].value,
                                            style: GoogleFonts.dosis(
                                              color: Colors.orange[300],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class _AxieTokenDetails extends StatelessWidget {
  final TokenSlotModel tokenSlot;
  const _AxieTokenDetails({
    Key key,
    @required this.tokenSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BinderState binderState = Provider.of<BinderState>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () {
        binderState.closeTokenDetails();
        Navigator.pop(context);
      },
      child: Stack(
        children: [
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
          _AxieTokenCard(
            tokenSlot: tokenSlot,
          ),
        ],
      ),
    );
  }
}

class FilledPathPainter extends CustomPainter {
  const FilledPathPainter({
    @required this.path,
    @required this.color,
  });

  final Path path;
  final Color color;

  @override
  bool shouldRepaint(FilledPathPainter oldDelegate) =>
      oldDelegate.path != path || oldDelegate.color != color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool hitTest(Offset position) => path.contains(position);
}
