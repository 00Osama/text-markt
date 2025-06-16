import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:textmarkt/bloc/event_cubit.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/models/event.dart';
import 'package:textmarkt/pages/sub_pages/add_new_event.dart';
import 'package:textmarkt/widgets/event_builder.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  String getMonthName(int monthNumber) {
    const monthNames = [
      "Invalid month",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return (monthNumber >= 1 && monthNumber <= 12)
        ? monthNames[monthNumber]
        : "Invalid month";
  }

  Future<List<Event>> fetchEvents() async {
    if (events.isEmpty) {
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('events')
          .orderBy('dateTime', descending: true)
          .get();

      events = response.docs.map((doc) {
        var event = Event.fromJson(doc.data() as Map<String, dynamic>);
        event.id = doc.id;
        return event;
      }).toList();
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    DateTime today = DateTime.now();
    String monthName = getMonthName(today.month);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${today.day} $monthName, ${today.year}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Events',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        foregroundColor:
            Theme.of(context).floatingActionButtonTheme.foregroundColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewEvents(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          if (state is EventAddSuccess) {
            events.insert(
              0,
              Event(
                note: state.note,
                title: state.title,
                dateTime: state.dateTime,
                id: state.id,
              ),
            );
            events.sort((a, b) => b.dateTime.compareTo(a.dateTime));
            Navigator.pop(context);
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Event added successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is EventDeleteSuccess) {
            events.removeAt(state.index);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Event deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
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
          }
          if (state is EventAddFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('sorry, failed to add event'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is EventDeleteLoading) {
            return Expanded(
              child: Center(
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    LoadingAnimationWidget.threeRotatingDots(
                      color: const Color.fromARGB(255, 67, 143, 224),
                      size: 90,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            );
          }
          return FutureBuilder<List<Event>>(
            future: fetchEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        LoadingAnimationWidget.threeRotatingDots(
                          color: const Color.fromARGB(255, 67, 143, 224),
                          size: 90,
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      Image.asset(
                        'assets/images/no.png',
                        width: screenHeight * 0.5,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        'No events found',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                );
              }

              return EventBuilder(
                events: snapshot.data!,
              );
            },
          );
        },
      ),
    );
  }
}
