import 'package:flutter/material.dart';

void openDialog(
  BuildContext context, {
  required String message,
  required String yes,
  required String no,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(10),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Flexible(
                  child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(no)),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(right: 40),
                      child:
                          TextButton(onPressed: onPressed, child: Text(yes))),
                ],
              )),
            ],
          ),
        ),
      );
    },
  );
}

void showProgressLoading() {}
