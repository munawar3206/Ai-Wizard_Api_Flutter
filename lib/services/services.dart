import 'package:flutter/material.dart';
import 'package:quizapp/widgets/drop_down.dart';
import 'package:quizapp/widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        backgroundColor: const Color.fromARGB(255, 109, 108, 108),
        context: context,
        builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TextWidget(
                  label: "Chosen Model : ",
                  color: Colors.black,
                  fontSize: 16,
                )),
                Flexible(child: DropDownWidget()),
              ],
            ),
          );
        });
  }
}
