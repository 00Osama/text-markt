import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/generated/l10n.dart';

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
    String formattedDate =
        '${DateFormat('EEEE, dd MMM yyyy').format(dateTime)}, '
        '${dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour)}:'
        '${dateTime.minute.toString().padLeft(2, '0')} '
        '${DateFormat('a').format(dateTime)}';
    final isExpired = dateTime.isBefore(DateTime.now());
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          S.of(context).eventPreview,
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
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.close_rounded,
                color: Theme.of(
                  context,
                ).floatingActionButtonTheme.foregroundColor,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 17),
              Text(
                isExpired ? S().eventExpired : S.of(context).Date,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: TextStyle(
                  color: isExpired ? Colors.red : null,
                  fontSize: isTablet ? 22 : 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(title.text, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 24),
              Text(
                S.of(context).Event,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(note.text, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
