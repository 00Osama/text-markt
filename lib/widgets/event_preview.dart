import 'package:flutter/material.dart';

class EventPreview extends StatelessWidget {
  const EventPreview({
    super.key,
    required this.title,
    required this.note,
  });

  final TextEditingController title;
  final TextEditingController note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        centerTitle: true,
        title: const Text(
          'Event Preview',
          style: TextStyle(
            color: Colors.grey,
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  maxLines: null,
                  cursorColor: const Color(0xff007AFF),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 80, 78, 78),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff979797),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: note,
                  maxLines: null,
                  cursorColor: const Color(0xff007AFF),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 80, 78, 78),
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff979797),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
