import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../game_constant.dart';
import '../logic/leaf_logic.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';

class LeafScreen extends StatefulWidget {
  const LeafScreen({super.key});
  static String routeName = "/leaf";

  @override
  State<LeafScreen> createState() => _LeafScreenState();
}

class _LeafScreenState extends State<LeafScreen> {
  Artboard? _riveArtboard;
  StateMachineController? mainStateController;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    if (mainStateController != null) {
      mainStateController!.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    if (mounted) {
      setState(() {
        _riveArtboard = LeafLogic.riveFile.mainArtboard.instance();
      });
    }

    mainStateController = StateMachineController.fromArtboard(_riveArtboard!, "State Machine 1");
    _riveArtboard!.addController(mainStateController!);
    updateProgress(50.0);
  }

  void updateProgress(double val) {
    SMINumber input = mainStateController!.findSMI("input");
    input.change(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Responsive.getDeviceWidth(),
        height: Responsive.getDeviceHeight(),
        child: Stack(fit: StackFit.expand, children: [
          Image(
            width: Responsive.getDeviceWidth(),
            height: Responsive.getDeviceHeight(),
            image: Util.getLocalImage(GameConstants.background),
            fit: BoxFit.fill,
          ),
          getTreeWidget(),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(LeafScreen.routeName),
          ))
        ]),
      ),
    );
  }

  Widget getTreeWidget() {
    return _riveArtboard == null
        ? Container(
            color: Colors.red.withOpacity(0.0),
          )
        : Transform.scale(
          scale : 1.0,
          child: Container(
            width: Responsive.getDeviceWidth(),
            height: Responsive.getDeviceHeight(),
              margin: EdgeInsets.only(bottom: Responsive.getDefaultHeightDim(BottomBar.height)),
              child: Stack(
                children: [
                  Rive(
                    artboard: _riveArtboard!,
                    enablePointerEvents: true,
                    // useArtboardSize: true,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
        );
  }
}
