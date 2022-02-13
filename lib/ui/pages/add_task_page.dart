// ignore_for_file: slash_for_doc_comments, avoid_unnecessary_containers, unnecessary_string_interpolations, non_constant_identifier_names, prefer_final_fields, unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController task_controller = Get.put(TaskController());
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _noteecontroller = TextEditingController();
  DateTime _selectdatatime = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  //!install outside library is entery to Dateformat */
  String _endtTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> _remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectcolor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: primaryClr,
            )),
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
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: Headingstyle,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter Title Here',
                controller: _titlecontroller,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note Here',
                controller: _noteecontroller,
              ),
              InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectdatatime),
                  widget: IconButton(
                    onPressed: () {
                      _getDataFromUser();
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStarttime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InputField(
                        title: 'End Time',
                        hint: _endtTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStarttime: false);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        )),
                  )
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes Early',
                widget: DropdownButton(
                  dropdownColor: Colors.blue,
                  items: _remindList
                      .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                '$value',
                                style: const TextStyle(color: Colors.white),
                              )))
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? Newvalue) {
                    setState(() {
                      _selectedRemind = int.parse(Newvalue!);
                    }); //**to changed numbers in this fiels */
                  },
                ),
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRepeat ',
                widget: DropdownButton(
                  dropdownColor: Colors.blue,
                  items: _repeatList
                      .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                '$value',
                                style: const TextStyle(color: Colors.white),
                              )))
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? Newvalue) {
                    setState(() {
                      _selectedRepeat = Newvalue!;
                    }); //*to changed numbers in this fields */
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  colorPalete(),
                  MyButton(
                      label: 'Craete task',
                      onTap: () {
                        _validationDate();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validationDate() {
    if (_titlecontroller.text.isNotEmpty && _noteecontroller.text.isNotEmpty) {
      addtasksToDB();
      Get.back();
    } else if (_titlecontroller.text.isEmpty || _noteecontroller.text.isEmpty) {
      Get.snackbar('required', 'All fields required  ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.pink,
          icon: const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    } else {
      print('######### SomeThing BAD HAPPENDES######');
    }
  }

  addtasksToDB() async {
    try {
      int value = await task_controller.addtask(
        //todo:get the data from the database
        task: Task(
          title: _titlecontroller.text,
          note: _noteecontroller.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectdatatime),
          startTime: _startTime,
          endTime: _endtTime,
          color: _selectcolor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      print('$value');
    } catch (e) {
      print('Error');
    }
  }

  Column colorPalete() {
    return Column(
      children: [
        Text(
          'color',
          style: titlestyle,
        ),
        Wrap(
          children: List.generate(
            3,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  _selectcolor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    child: _selectcolor == index
                        ? const Icon(
                            Icons.done,
                            size: 20,
                          )
                        : null,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _getDataFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectdatatime,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectdatatime = _pickedDate;
      });
    } else {
      print('NULL');
    }
  }

  void _getTimeFromUser({required bool isStarttime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStarttime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(minutes: 15),
              ),
            ),
    );
    String formattedTime = _pickedTime!.format(context);
    if (isStarttime)
      setState(() {
        _startTime = formattedTime;
      });
    if (!isStarttime)
      setState(() {
        _startTime = formattedTime;
      });
    else {
      print('***someThing Wronggg***');
    }
  }
}
