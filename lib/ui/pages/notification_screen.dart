// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.PayLoad}) : super(key: key);
  final String PayLoad;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _paylaod = '';
  @override
  void initState() {
    // ignore: todo

    super.initState();
    _paylaod = widget.PayLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          /** to siprate the text in AppBar */
          _paylaod.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Hello,Ahmed',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'You Have A new Remeinder',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35), color: primaryClr),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.text_format,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Title',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        /** to siprate the text in AppBar */
                        _paylaod.toString().split('|')[0],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        /** to siprate the text in AppBar */
                        _paylaod.toString().split('|')[1],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.date_range_sharp,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Date',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        /** to siprate the text in AppBar */
                        _paylaod.toString().split('|')[2],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
