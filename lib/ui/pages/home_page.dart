// ignore_for_file: avoid_unnecessary_containers, unused_import, unused_local_variable

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.intializationNotification;
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
  }

  final TaskController _taskcontroller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            ThemeServices().isSwiteched();
            /* notifyHelper.displayNotification(
                  title: 'changed Theme', body: 'gogod');
              notifyHelper.scheduledNotifications();*/
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 20,
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        children: [
          _addTaskbar(),
          _adDAteBar(),
          const SizedBox(
            height: 5,
          ),
          _showTask(),
        ],
      ),
    );
  }

  _addTaskbar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Subtitlestyle,
              ),
              Text(
                'Today',
                style: Headingstyle,
              )
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskcontroller.getTask();
                /** wait me back to the main sceen and add the task use async */
              })
        ],
      ),
    );
  }

  _adDAteBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: (SizeConfig.orientation == Orientation.landscape)
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (BuildContext context, index) {
          var task = _taskcontroller.taskList[index];
          var hours = task.startTime.toString().split(':')[0];
          var minutes = task.startTime.toString().split(':')[1];
          debugPrint('My Time is' + hours);
          debugPrint('My minutes is' + minutes);

          notifyHelper.scheduledNotification(
              int.parse(task.startTime.toString().split(':')[0]),
              int.parse(task.startTime.toString().split(':')[1]),
              task);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1300),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: InkWell(
                  onTap: () {
                    showbuttomsheet(context, task);
                  },
                  child: TaskTile(task),
                ),
              ),
            ),
          );
        },
        itemCount: _taskcontroller.taskList.length,
      ),
    );

    /*** 
     Expanded(
      child: InkWell(
        onTap: () {
          showbuttomsheet(
            context,
            Task(
              title: 'Title 1 ',
              note: 'Write anyThing',
              isCompleted: 1,
              startTime: '2:40',
              endTime: '20:18',
              color: 1,
            ),
          );
        },
        child: TaskTile(
          Task(
            title: 'Title 1 ',
            note: 'Write anyThing',
            isCompleted: 1,
            startTime: '2:40',
            endTime: '20:18',
            color: 1,
          ),
        ),
      ),
      /*Obx(() {
      if (_taskcontroller.taskList.isEmpty) {
        return _taskmessage();
      } else {
        return Container(
          height: 0,
        );
      }
    })*/
    ); 
    */
  }

  // ignore: unused_element
  _taskmessage() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: SingleChildScrollView(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              alignment: WrapAlignment.center,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 220,
                      ),
                SvgPicture.asset(
                  /**to add background image to the body */
                  'images/task.svg',
                  color: primaryClr.withOpacity(.5),
                  height: 90,
                  semanticsLabel: 'Task',
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Text(
                    "You Don't have any tasks yet now\n Do You have add any tasks!",
                    style: SubHeadingstyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                        height: 120,
                      )
                    : const SizedBox(
                        height: 180,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showbuttomsheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * .6
                : SizeConfig.screenHeight * .8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * .30
                : SizeConfig.screenHeight * .38),
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Gap(20),
            task.isCompleted == 1
                ? Container()
                : _buildButtomSheet(
                    lable: 'Task Completed',
                    onTap: () {
                      Get.back();
                    },
                    clr: primaryClr),
            _buildButtomSheet(
                lable: ' Delete Task ',
                onTap: () {
                  Get.back();
                },
                clr: primaryClr),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            _buildButtomSheet(
                lable: 'Cancle',
                onTap: () {
                  Get.back();
                },
                clr: primaryClr),
            const Gap(20),
          ],
        ),
      ),
    ));
  }

  _buildButtomSheet({
    required String lable,
    required Function() onTap,
    required Color clr,
    bool isclose = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * .9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isclose
                ? Get.isDarkMode
                    ? Colors.grey[300]!
                    : Colors.grey[600]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isclose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(lable,
              style: isclose
                  ? titlestyle
                  : titlestyle.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
