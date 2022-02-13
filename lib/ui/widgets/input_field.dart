// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  /** *****This  widget like Icon ,button etc.... *********/
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titlestyle,
          ),
          Container(
            width: SizeConfig.screenWidth,
            height: 50,
            padding: const EdgeInsets.only(left: 12),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget != null ? true : false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    style: Subtitlestyle,
                    controller: controller,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: Subtitlestyle,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context).backgroundColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context).backgroundColor)),
                    ),
                  ),
                ),
                widget ?? Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
