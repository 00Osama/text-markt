import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/routing/app_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/core/helpers/success_snackbar_helper.dart';
import 'package:text_markt/features/events/presentation/cubits/event_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/events/domain/entities/event.dart';
import 'package:text_markt/features/events/presentation/widgets/event_builder.dart';
import 'package:text_markt/globals.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: isTablet ? 100 : kToolbarHeight,
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
      floatingActionButton: SizedBox(
        width: isTablet ? 90 : 55,
        height: isTablet ? 90 : 55,
        child: FloatingActionButton(
          backgroundColor: Theme.of(
            context,
          ).floatingActionButtonTheme.backgroundColor,
          foregroundColor: Theme.of(
            context,
          ).floatingActionButtonTheme.foregroundColor,
          onPressed: () {
            context.push(AppRoutes.addEvent);
          },
          child: Icon(Icons.add_rounded, size: isTablet ? 45 : 24),
        ),
      ),

      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(complete: Text(S().refreshCompleted)),
        controller: refreshController,
        onRefresh: () {
          setState(() {
            events.clear();
            refreshController.refreshCompleted();
          });
        },
        child: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            print('----------------- Consumer State: $state -----------------');

            if (state is EventAddSuccess) {
              context.pop();
              successSnackBar(
                context: context,
                title: S.of(context).eventAddedSuccessfully,
              );
            }

            if (state is EventDeleteSuccess) {
              successSnackBar(
                context: context,
                title: S.of(context).eventDeletedSuccessfully,
              );
            }

            if (state is EventAddFail) {
              errorSnackBar(
                context: context,
                title: S.of(context).failedToAddEvent,
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
              stream: context.read<EventCubit>().getEvents(),
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
                          fontSize: isTablet ? 24 : screenWidth * 0.05,
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
      ),
    );
  }
}
