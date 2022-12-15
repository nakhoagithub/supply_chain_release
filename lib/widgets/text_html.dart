import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:supply_chain/constrain.dart';
import 'package:url_launcher/url_launcher.dart';

class TextHTML extends StatelessWidget {
  final String text;
  const TextHTML({super.key, required this.text});

  void _openLinkTX(String? tx) async {
    if (tx != null) {
      final Uri uri = Uri.parse("${Constants.scanTestnet}tx/$tx");
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openLinkAddress(String? address) async {
    if (address != null) {
      final Uri uri = Uri.parse("${Constants.scanTestnet}address/$address");
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      tags: {
        'link': StyledTextActionTag(
          (text, attributes) {
            String? tx = attributes['blockchain_tx'];
            if (tx != null) {
              _openLinkTX(tx);
            }
            String? address = attributes['blockchain_address'];
            if (address != null) {
              _openLinkAddress(address);
            }
          },
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      },
    );
  }
}
