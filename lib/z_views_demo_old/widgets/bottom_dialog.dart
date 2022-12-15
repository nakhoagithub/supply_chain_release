import 'package:flutter/material.dart';
import 'package:supply_chain/theme.dart';

Future<void> showBottomDialog(context, String label) async {
  showGeneralDialog(
    barrierLabel: label,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox.expand(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: ThemeApp.textStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
}

Future<void> bottomDialog(context, message, Function func,
    {double? height}) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        margin: const EdgeInsets.all(20),
        height: height ?? 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const SizedBox(
                              width: 120,
                              child: Text(
                                "Không",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              func();
                            },
                            child: const SizedBox(
                              width: 120,
                              child: Text(
                                "Có",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            )),
                      ],
                    ),
                  )),
            ]),
      );
    },
  );
}