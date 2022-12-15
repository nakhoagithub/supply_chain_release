import 'package:flutter/material.dart';
import 'package:supply_chain/z_views_demo_old/widgets/bottom_dialog.dart';


class ButtonLogout extends StatelessWidget {
  const ButtonLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomDialog(context, "Bạn có muốn đăng xuất?", () {
        });
      },
      child: SizedBox(
        height: 45,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Đăng xuất",
                style: TextStyle(color: Colors.red[800], fontSize: 16)),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              color: Colors.red[800],
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
