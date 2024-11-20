import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:textmarkt/bloc/event_cubit.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/models/event.dart';
import 'package:textmarkt/widgets/event_text_field.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        centerTitle: true,
        title: const Text(
          'add new event',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (titleController.text.trim().isEmpty ||
              noteController.text.trim().isEmpty ||
              datePickerController.text.isEmpty ||
              timePickerController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Please fill all fields before uploading.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          } else {
            String selectedDate = datePickerController.text;
            String selectedTime = timePickerController.text;
            DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(
              '$selectedDate $selectedTime',
            );

            context.read<EventCubit>().addNewEvent(
                  noteController.text,
                  titleController.text,
                  dateTime,
                );
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.save_rounded,
        ),
      ),
      body: BlocConsumer<EventCubit, EventState>(listener: (context, state) {
        if (state is EventAddLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            },
          );
        } else if (state is EventAddSuccess) {
          DateTime addedDateTime = DateTime.parse(state.dateTime);
          for (int i = 0; i < events.length; i++) {
            DateTime currentDateTime = DateTime.parse(events[i].dateTime);
            if (addedDateTime.day >= currentDateTime.day) {
              events.insert(
                0,
                Event(
                  note: state.note,
                  title: state.title,
                  dateTime: state.dateTime,
                  id: state.id,
                ),
              );
              return;
            }
          }

          Navigator.pop(context);
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Event uploaded successfully'),
              backgroundColor: Colors.green,
            ),
          );

          titleController.clear();
          noteController.clear();
          datePickerController.clear();
          timePickerController.clear();
        } else if (state is EventAddFail) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('sorry, failed to add event'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }, builder: (context, snapshot) {
        return ListView(
          children: [
            EventTextField(
              controller: titleController,
              hintText: 'type your title here.',
              fieldTitle: 'Title',
              readOnly: false,
            ),
            EventTextField(
              controller: noteController,
              hintText: 'type your note here.',
              fieldTitle: 'Note',
              readOnly: false,
            ),
            EventTextField(
              readOnly: true,
              controller: datePickerController,
              hintText:
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              fieldTitle: 'Date',
              suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2035),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(date);
                    setState(() {
                      datePickerController.text = formattedDate;
                    });
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidCalendarDays,
                  color: Colors.grey[500],
                ),
              ),
            ),
            EventTextField(
              readOnly: true,
              controller: timePickerController,
              hintText:
                  '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
              fieldTitle: 'Time',
              suffixIcon: IconButton(
                onPressed: () async {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    String formattedTime =
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                    setState(() {
                      timePickerController.text = formattedTime;
                    });
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidClock,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
