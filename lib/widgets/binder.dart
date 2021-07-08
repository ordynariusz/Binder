import 'package:animations/animations.dart';
import 'package:better_page_turn/horizontal_flip_page_turn.dart';
import 'package:binder/models/data.dart';
import 'package:flip/flip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:transparent_image/transparent_image.dart';

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
    this.autoOpen = false,
    this.showCoverText = true,
    this.showPlayButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      aspectRatio: 7.0 / 5.0,
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
        flipController.flip();
      });

    return Stack(children: [
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
      showPlayButton == true
          ? Column(
              children: [
                Spacer(
                  flex: 12,
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Spacer(
                        flex: 30,
                      ),
                      Expanded(
                        flex: 6,
                        child: FittedBox(
                          child: IconButton(
                              icon: Icon(
                                Icons.play_arrow,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                flipController.flip();
                              }),
                        ),
                      ),
                      Spacer(
                        flex: 1,
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
    ]);
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
                      flex: 7,
                    ),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        child: Text(
                          '${binder.title}',
                          maxLines: 1,
                          style: GoogleFonts.dosis(
                            color: Colors.white,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 7,
                    ),
                  ],
                ),
              )
            : Text(''),
      ],
    );
  }
}

class _BinderOpen extends StatelessWidget {
  final BinderModel binder;
  const _BinderOpen({
    Key key,
    @required this.binder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Spacer(
                      flex: 12,
                    ),
                    Expanded(
                      child: FittedBox(
                        child: IconButton(
                            icon: Icon(
                              Icons.share,
                            ),
                            color: Colors.white,
                            onPressed: () {}),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 9,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      child: FittedBox(
                        child: IconButton(
                            icon: Icon(
                              Icons.navigate_before,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              horizontalFlipPageTurnController
                                  .animToLeftWidget();
                            }),
                      ),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    Expanded(
                      child: FittedBox(
                        child: IconButton(
                            icon: Icon(
                              Icons.navigate_next,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              horizontalFlipPageTurnController
                                  .animToRightWidget();
                            }),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
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
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
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
                    Expanded(
                      flex: 18,
                      child: tokenSlot.attributes != null
                          ? ListView(
                              children: [
                                for (int i = 0;
                                    i < tokenSlot.attributes.length;
                                    i++)
                                  ListTile(
                                    title: Text(
                                      tokenSlot.attributes[i].value,
                                    ),
                                    subtitle: Text(
                                      tokenSlot.attributes[i].name,
                                    ),
                                  )
                              ],
                            )
                          : Text(""),
                    )
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
            onHover: (event) {},
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
