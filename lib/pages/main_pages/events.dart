import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/bloc/event_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/models/event.dart';
import 'package:text_markt/pages/sub_pages/add_new_event.dart';
import 'package:text_markt/widgets/event_builder.dart';

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
      "December",
    ];
    return (monthNumber >= 1 && monthNumber <= 12)
        ? monthNames[monthNumber]
        : "Invalid month";
  }

  Stream<List<Event>> streamEvents() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('events')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            var event = Event.fromJson(doc.data());
            event.id = doc.id;
            return event;
          }).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

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
              DateFormat(
                'EEEE, d MMMM y',
                Localizations.localeOf(context).toLanguageTag(),
              ).format(DateTime.now()),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              S.of(context).eventsTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(
          context,
        ).floatingActionButtonTheme.backgroundColor,
        foregroundColor: Theme.of(
          context,
        ).floatingActionButtonTheme.foregroundColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewEvents()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          print('----------------- Consumer State: $state -----------------');

          if (state is EventAddSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  S.of(context).eventAddedSuccessfully,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is EventDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  S.of(context).eventDeletedSuccessfully,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is EventAddFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  S.of(context).failedToAddEvent,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          print('----------------- Builder State: $state -----------------');

          if (state is EventDeleteLoading) {
            return Center(
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
            );
          }

          return StreamBuilder<List<Event>>(
            stream: streamEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
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
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Column(
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
                      S.of(context).noEvents,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                );
              }

              return EventBuilder(events: snapshot.data!);
            },
          );
        },
      ),
    );
  }
}
