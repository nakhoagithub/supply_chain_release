import 'package:flutter/material.dart';

/// Nếu không có children thì thêm icon và label

class MenuItemDrawer extends StatefulWidget {
  final List<Widget>? children;
  final Icon? icon;
  final String? label;
  final double? width;
  final double? height;
  final Function onTab;
  const MenuItemDrawer(
      {Key? key,
      this.children,
      this.icon,
      this.label,
      this.width,
      this.height,
      required this.onTab})
      : super(key: key);

  @override
  State<MenuItemDrawer> createState() => _MenuItemDrawerState();
}

class _MenuItemDrawerState extends State<MenuItemDrawer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTab(),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
        // decoration: const BoxDecoration(
        //     border:
        //         Border(bottom: BorderSide(width: 0.6, color: Colors.black38))),
        width: widget.width ?? double.infinity,
        height: widget.height ?? 45,
        child: Row(
          children: widget.children ??
              [
                widget.icon ?? const Icon(Icons.create),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  widget.label ?? "Menu Item",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ))
              ],
        ),
      ),
    );
  }
}
