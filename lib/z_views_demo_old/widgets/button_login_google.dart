import 'package:flutter/material.dart';
import 'package:supply_chain/theme.dart';

class ButtonLoginGoogle extends StatelessWidget {
  final Function()? onPressed;
  final double width;
  const ButtonLoginGoogle({Key? key, this.onPressed, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 40,
          width: width,
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Image.asset('assets/images/google.png')),
              Expanded(
                child: Text(
                  'Đăng nhập Google',
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
