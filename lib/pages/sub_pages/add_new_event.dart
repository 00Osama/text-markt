import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/bloc/event_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/widgets/event_text_field.dart';

class AddNewEvents extends StatefulWidget {
  const AddNewEvents({super.key});

  @override
  State<AddNewEvents> createState() => _AddNewEventsState();
}

class _AddNewEventsState extends State<AddNewEvents> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController timePickerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.clear();
    noteController.clear();
    datePickerController.clear();
    timePickerController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    datePickerController.dispose();
    timePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          S.of(context).newEvent,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(
                context,
              ).floatingActionButtonTheme.backgroundColor,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close_rounded,
                color: Theme.of(
                  context,
                ).floatingActionButtonTheme.foregroundColor,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).floatingActionButtonTheme.backgroundColor,
              ),
              child: IconButton(
                onPressed: () async {
                  if (titleController.text.trim().isEmpty ||
                      noteController.text.trim().isEmpty ||
                      datePickerController.text.isEmpty ||
                      timePickerController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          S.of(context).fillAllFields,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  try {
                    final selectedDate =
                        datePickerController.text; // dd-MM-yyyy
                    final selectedTime = timePickerController.text; // HH:mm

                    final formattedDateTime = '$selectedDate $selectedTime';

                    final DateTime dateTime = DateFormat(
                      'dd-MM-yyyy HH:mm',
                      'en_US',
                    ).parseStrict(formattedDateTime);

                    context.read<EventCubit>().addNewEvent(
                      titleController.text,
                      noteController.text,
                      dateTime,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Invalid date/time format!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.done_rounded,
                  color: Theme.of(
                    context,
                  ).floatingActionButtonTheme.foregroundColor,
                ),
                iconSize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<EventCubit, EventState>(
        listener: (context, state) {
          if (state is EventAddLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: const Color.fromARGB(255, 67, 143, 224),
                    size: 90,
                  ),
                );
              },
            );
          }
          if (state is EventAddSuccess) {
            Navigator.pop(context);
          }
        },
        child: ListView(
          children: [
            EventTextField(
              controller: titleController,
              hintText: S.of(context).TitleHint,
              fieldTitle: S.of(context).title,
              readOnly: false,
            ),
            EventTextField(
              maxLines: 5,
              controller: noteController,
              hintText: S.of(context).EventHint,
              fieldTitle: S.of(context).Event,
              readOnly: false,
            ),
            // 🗓️ Date Picker Field
            EventTextField(
              readOnly: true,
              controller: datePickerController,
              hintText: DateFormat('dd-MM-yyyy').format(DateTime.now()),
              fieldTitle: S.of(context).Date,
              suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2035),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    final formattedDate = DateFormat(
                      'dd-MM-yyyy',
                      'en_US',
                    ).format(date);
                    setState(() => datePickerController.text = formattedDate);
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidCalendarDays,
                  color: Colors.grey[500],
                ),
              ),
            ),
            // ⏰ Time Picker Field
            EventTextField(
              readOnly: true,
              controller: timePickerController,
              hintText: DateFormat('HH:mm').format(DateTime.now()),
              fieldTitle: S.of(context).Time,
              suffixIcon: IconButton(
                onPressed: () async {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    final formattedTime =
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                    setState(() => timePickerController.text = formattedTime);
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidClock,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
