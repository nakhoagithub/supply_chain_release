// import 'package:flutter/material.dart';
// import 'package:supply_chain/constrain.dart';

// class BottomNavBar extends StatelessWidget {
//   final List<BottomNavItem> items;
//   final int selectedIndex;
//   final ValueChanged<int> onItemSelected;
//   final Color? backgroundColor;
//   final double iconSize;
//   final Duration animationDuration;
//   const BottomNavBar(
//       {Key? key,
//       required this.items,
//       required this.selectedIndex,
//       required this.onItemSelected,
//       this.backgroundColor,
//       this.iconSize = 24,
//       this.animationDuration = const Duration(milliseconds: 500)})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 55,
//       width: widthScreen,
//       child: Card(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: items.map((item) {
//               var index = items.indexOf(item);
//               return GestureDetector(
//                 onTap: () => onItemSelected(index),
//                 child: _ItemWidget(
//                   item: item,
//                   iconSize: iconSize,
//                   isSelected: index == selectedIndex,
//                   backgroundColor: backgroundColor,
//                   animationDuration: animationDuration,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ItemWidget extends StatelessWidget {
//   final double iconSize;
//   final bool isSelected;
//   final BottomNavItem item;
//   final Color? backgroundColor;
//   final Duration animationDuration;

//   const _ItemWidget({
//     Key? key,
//     required this.item,
//     required this.isSelected,
//     this.backgroundColor,
//     required this.animationDuration,
//     required this.iconSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     if (_width > widthScreen) {
//       _width = widthScreen;
//     }
//     return Padding(
//       padding: const EdgeInsets.only(left: 5, right: 5),
//       child: AnimatedContainer(
//         alignment: Alignment.center,
//         duration: const Duration(seconds: 1),
//         width: isSelected ? _width * 0.3 : _width * 0.15,
//         curve: Curves.fastLinearToSlowEaseIn,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: isSelected
//                 ? Colors.blue
//                 : Colors.transparent),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 5, right: 5),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               item.icon,
//               isSelected
//                   ? const SizedBox(
//                       width: 5,
//                     )
//                   : Container(),
//               _width <= widthScreenSmall
//                   ? Container()
//                   : Flexible(
//                       child: AnimatedOpacity(
//                         duration: const Duration(milliseconds: 200),
//                         opacity: isSelected ? 1 : 0,
//                         child: item.title,
//                       ),
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TitleBottomNav extends StatelessWidget {
//   final String title;
//   const TitleBottomNav({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //final theme = Provider.of<ThemeProvider>(context);
//     return Text(
//       title,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
// }

// class BottomNavItem {
//   final Widget icon;
//   final TitleBottomNav title;
//   const BottomNavItem({
//     required this.icon,
//     required this.title,
//   });
// }
