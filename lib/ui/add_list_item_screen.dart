import 'package:flutter/material.dart';
import 'package:ggc/logic/game_logic.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../screen_transition.dart';
import '../util.dart';
import 'bottom_bar.dart';
import 'common_widgets.dart';
import 'take_bag_screen.dart';

class AddListItemScreen extends StatefulWidget {
  static String routeName = "/AddListItem";
  const AddListItemScreen({super.key});

  @override
  State<AddListItemScreen> createState() => _AddListItemScreenState();
}

class _AddListItemScreenState extends State<AddListItemScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  bool _showTextInput = false;
  final FocusNode _focusNode = FocusNode();
  late List<String> items = [];
  @override
  void initState() {
    super.initState();
    items = GameLogic.getListData();
    _focusNode.addListener(() {
      if (_controller.text.isNotEmpty) {
        _addItem(_controller.text);
      }
      if (!_focusNode.hasFocus && _controller.text.isEmpty) {
        setState(() {
          _showTextInput = false;
        });
      }
    });
  }

  void _addItem(String description) {
    if (description.isNotEmpty) {
      setState(() {
        GameLogic.gameData.listData[description] = false;
        items.add(description);
        _controller.clear();
        _showTextInput = false;
        GameLogic.saveData();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      String desc = items[index];
      items.removeAt(index);
      GameLogic.gameData.listData.remove(desc);
      GameLogic.saveData();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.getDeviceWidth(),
      height: Responsive.getDeviceHeight(),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: Util.getLocalImage(GameConstants.background),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            color: Colors.transparent,
            width: Responsive.getDeviceWidth(),
            height: Responsive.getDeviceHeight(),
            child: Stack(fit: StackFit.expand, children: [
              Positioned(
                  child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const ScreenTopBar(barValue: 0.1),
                    addItemsWidget(),
                    listWidget(),
                  ],
                ),
              )),
              plusButtonWidget(),
              Positioned(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ScreenBottomBar(
                    item: items.length,
                    buttonText: "ITEMS ADDED",
                    onButtonTap: onBottomButtonTap),
              )),
            ])),
      ),
    );
  }

  void onBottomButtonTap() {
    if (items.isEmpty) {
      return;
    }
    Navigator.push(
        context,
        ScreenTransition.slideRouteToLeft(
            TakeBagScreen.routeName, const TakeBagScreen()));
  }

  Widget addItemsWidget() {
    return Container(
      height: Responsive.getValueInPixel(100),
      width: Responsive.getDeviceWidth(),
      margin: EdgeInsets.only(left: Responsive.getValueInPixel(90)),
      child: Text(
        "Add Items",
        style: TextStyle(
          decoration: TextDecoration.none,
          color: const Color(0xff4B4B4B),
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: GameConstants.fontFamily,
          fontSize: Responsive.getFontSize(75),
        ),
        textScaleFactor: 1.0,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget plusButtonWidget() {
    return Positioned(
      top: Responsive.getDeviceHeight() * 0.80,
      right: Responsive.getDefaultWidthDim(100),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showTextInput = true;
          });
        },
        child: Container(
          width: Responsive.getValueInPixel(215),
          height: Responsive.getValueInPixel(228),
          child: Stack(children: [
            Container(
              width: Responsive.getValueInPixel(215),
              height: Responsive.getValueInPixel(228),
              child: Image(image: Util.getLocalImage(GameConstants.plusButton)),
            ),
            Center(
              child: Text(
                "+",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: Responsive.getFontSize(200),
                ),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget bottomBarWidget() {
    return Container(
      height: Responsive.getDefaultHeightDim(BottomBar.height),
      width: Responsive.getDeviceWidth(),
      color: Colors.white,
      child: Center(
        child: Stack(children: [
          Image(
            width: Responsive.getDefaultWidthDim(1178),
            height: Responsive.getDefaultHeightDim(158),
            image: Util.getLocalImage(GameConstants.listButton),
            fit: BoxFit.fill,
          ),
        ]),
      ),
    );
  }

  Widget topBarWidget() {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(200)),
      height: Responsive.getDefaultHeightDim(160),
      width: Responsive.getDeviceWidth(),
      color: Colors.transparent,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: Responsive.getValueInPixel(80)),
            width: Responsive.getValueInPixel(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: Responsive.getValueInPixel(80),
                  width: Responsive.getValueInPixel(80),
                  image: Util.getLocalImage(GameConstants.backIcon),
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            height: Responsive.getDefaultHeightDim(160),
            width: Responsive.getDefaultWidthDim(835),
            color: Colors.transparent,
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Responsive.getDefaultHeightDim(55),
                    width: Responsive.getDefaultWidthDim(825),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Responsive.getValueInPixel(60)))),
                    child: Row(
                      children: [
                        Container(
                            height: Responsive.getDefaultHeightDim(55),
                            width: Responsive.getDefaultWidthDim(100),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment(0.49999999999999994,
                                        -3.0616171314629196e-17),
                                    end: Alignment(0.49999999999999994,
                                        0.9999999999999999),
                                    colors: [
                                      Color(0xff7ee751),
                                      Color(0xff38c53c)
                                    ]),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    Responsive.getValueInPixel(60))))),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Image(
                      height: Responsive.getValueInPixel(150),
                      width: Responsive.getValueInPixel(150),
                      image: Util.getLocalImage(GameConstants.giftIcon))
                ],
              ),
            ]),
          ),
        )
      ]),
    );
  }

  Widget listWidget() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(
            top: Responsive.getDefaultHeightDim(20),
            bottom: Responsive.getDefaultHeightDim(300)),
        itemCount: items.length + (_showTextInput ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (_showTextInput && index == items.length) {
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: Responsive.getDefaultHeightDim(222),
                      margin:
                          EdgeInsets.only(top: Responsive.getValueInPixel(40)),
                      child: Stack(children: [
                        Image(
                            image: Util.getLocalImage(GameConstants.listTile)),
                        Container(
                          padding: EdgeInsets.only(
                              left: Responsive.getValueInPixel(40),
                              right: Responsive.getValueInPixel(40)),
                          child: TextField(
                            autofocus: true,
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Enter item description',
                            ),
                            focusNode: _focusNode,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }
          return Dismissible(
              key: Key(items[index]),
              onDismissed: (direction) {
                _removeItem(index);
              },
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.transparent,
                child: const Icon(Icons.delete),
              ),
              child: Container(
                  margin: EdgeInsets.only(top: Responsive.getValueInPixel(40)),
                  padding: EdgeInsets.only(
                      left: Responsive.getValueInPixel(50),
                      right: Responsive.getValueInPixel(50)),
                  child: Stack(children: [
                    Image(image: Util.getLocalImage(GameConstants.listTile)),
                    Container(
                      padding: EdgeInsets.only(
                          left: Responsive.getValueInPixel(50),
                          top: Responsive.getValueInPixel(80)),
                      child: Text(
                        items[index],
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: const Color(0xff4B4B4B),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: GameConstants.fontFamily,
                          fontSize: Responsive.getFontSize(70),
                        ),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ])));
        },
      ),
    );
  }
}
