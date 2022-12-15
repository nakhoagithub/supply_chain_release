// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:supply_chain/config_application.dart';
// import 'package:supply_chain/constrain.dart';
// import 'package:supply_chain/handler/web3_login.dart';
// import 'package:supply_chain/views/widgets/button_drawer.dart';
// import 'package:supply_chain/views/widgets/button_login_google.dart';
// import 'package:supply_chain/views/widgets/button_logout.dart';

// class DrawerMain extends StatefulWidget {
//   final double? size;
//   final double? sizeWithScreen;
//   const DrawerMain({Key? key, this.size, this.sizeWithScreen})
//       : super(key: key);

//   @override
//   State<DrawerMain> createState() => _DrawerMainState();
// }

// class _DrawerMainState extends State<DrawerMain> implements ConnectInternetImp {
//   bool currentUser = getIt<SharedPreferencesApp>()
//           .getSharedPreferences
//           .getBool('currentUser') ??
//       false;
//   String? profileImage = getIt<SharedPreferencesApp>()
//       .getSharedPreferences
//       .getString('profileImage');
//   String? email =
//       getIt<SharedPreferencesApp>().getSharedPreferences.getString('email');
//   String? name =
//       getIt<SharedPreferencesApp>().getSharedPreferences.getString('name');

//   // connect internet
//   bool internet = false;
//   ConnectInternet? connectInternet;

//   @override
//   void initState() {
//     super.initState();
//     connectInternet = ConnectInternet(view: this);
//     connectInternet!.networkConnect();
//     initAsync();
//   }

//   void initAsync() async {}

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width * 0.8;
//     if (width > widthScreen) {
//       width = widthScreen * 0.8;
//     }
//     return SafeArea(
//       child: Container(
//         color: Colors.amber,
//         width: width,
//         child: Drawer(
//           child: !internet
//               ? const Center(
//                   child: Text("Không có kết nối Internet"),
//                 )
//               : !currentUser
//                   ? Center(
//                       child: ButtonLoginGoogle(
//                         width: 250,
//                         onPressed: () {},
//                       ),
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                           _headerDrawer(width, profileImage, email, name),
//                           Expanded(
//                               child: Container(
//                             margin: const EdgeInsets.only(top: 5, bottom: 5),
//                             child: SingleChildScrollView(
//                               child: _bodyDrawer(),
//                             ),
//                           )),
//                           const ButtonLogout()
//                         ]),
//         ),
//       ),
//     );
//   }

//   Widget _headerDrawer(
//       double width, String? profileImage, String? email, String? name) {
//     return SizedBox(
//       height: 160,
//       child: ClipRRect(
//         child: Stack(children: [
//           Image.asset(
//             "assets/images/supply_chain_background.jpg",
//             width: width,
//             fit: BoxFit.cover,
//           ),
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 20),
//                   child: Text(
//                     "Supply Chain",
//                     style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22,
//                         shadows: [
//                           Shadow(
//                             color: Colors.white54.withOpacity(0.8),
//                             offset: const Offset(1.5, 1.5),
//                             blurRadius: 1,
//                           ),
//                         ]),
//                   ),
//                 ),
//                 const Spacer(),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 10, left: 10),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       profileImage != null
//                           ? Container(
//                               width: 60.0,
//                               height: 60.0,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: NetworkImage(profileImage)),
//                                   borderRadius: BorderRadius.circular(30)),
//                             )
//                           : const Icon(
//                               Icons.account_circle,
//                               size: 60,
//                               color: Colors.black45,
//                             ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             name ?? "Họ và Tên",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.grey.withOpacity(0.8),
//                                     offset: const Offset(1.5, 1.5),
//                                     blurRadius: 1,
//                                   ),
//                                 ]),
//                           ),
//                           Text(
//                             email ?? "Địa chỉ email",
//                             style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 16,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.grey.withOpacity(0.8),
//                                     offset: const Offset(1.5, 1.5),
//                                     blurRadius: 1,
//                                   ),
//                                 ]),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ),
//     );
//   }

//   Widget _bodyDrawer() {
//     return Column(
//       children: [
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               margin: const EdgeInsets.only(left: 10, top: 10),
//               child: const Text(
//                 "Thông tin",
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//             )),
//         MenuItemDrawer(
//           label: "Thông tin tài khoản",
//           icon: const Icon(Icons.account_box_outlined),
//           onTab: () {
//             Navigator.pushNamed(context, '/profile_manager');
//           },
//         ),
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Divider(
//             color: Colors.black87,
//             height: 1,
//           ),
//         ),
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               margin: const EdgeInsets.only(left: 10),
//               child: const Text(
//                 "Quản lý",
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//             )),
//         MenuItemDrawer(
//           label: "Quản lý Sản Phẩm",
//           icon: const Icon(Icons.warehouse_outlined),
//           onTab: () {
//             Navigator.pushNamed(context, '/product_manager');
//           },
//         ),
//         MenuItemDrawer(
//           label: "Lịch sử Sản Phẩm",
//           icon: const Icon(Icons.history_rounded),
//           onTab: () {
//             Navigator.pushNamed(context, '/product_history');
//           },
//         ),
//         MenuItemDrawer(
//           label: "Danh sách công ty thành viên",
//           icon: const Icon(Icons.list_rounded),
//           onTab: () {
//             Navigator.pushNamed(context, '/list_company');
//           },
//         ),
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Divider(
//             color: Colors.black87,
//             height: 1,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void connected(bool connected) {
//     setState(() {
//       internet = connected;
//     });
//   }
// }
