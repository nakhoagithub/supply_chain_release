import 'package:flutter/material.dart';
import 'package:supply_chain/theme.dart';

class AppBarSuplyChain extends StatefulWidget {
  final Function onPressed;
  const AppBarSuplyChain({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<AppBarSuplyChain> createState() => _AppBarSuplyChainState();
}

class _AppBarSuplyChainState extends State<AppBarSuplyChain> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => widget.onPressed(), icon: const Icon(Icons.menu)),
      title: Text(
        "Supply Chain",
        style: ThemeApp.textStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
