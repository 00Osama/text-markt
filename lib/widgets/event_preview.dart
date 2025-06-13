import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPreview extends StatelessWidget {
  const EventPreview({
    super.key,
    required this.title,
    required this.note,
    required this.dateTime,
  });

  final TextEditingController title;
  final TextEditingController note;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    String formattedDate = '${DateFormat('dd MMM yyyy').format(dateTime)}, '
        '${dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour)}:'
        '${dateTime.minute.toString().padLeft(2, '0')} '
        '${DateFormat('a').format(dateTime)}';

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        centerTitle: true,
        title: Text(
          'Event Preview',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[400],
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 17),
              Text(
                'Date',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 80, 78, 78),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Title',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title.text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 80, 78, 78),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Note',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note.text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 80, 78, 78),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
