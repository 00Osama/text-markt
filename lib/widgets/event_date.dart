import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textmarkt/bloc/event_cubit.dart';

class EventDate extends StatelessWidget {
  const EventDate({
    super.key,
    required this.monthName,
    required this.dayNumber,
    required this.dayName,
    required this.id,
  });

  final String monthName;
  final int dayNumber;
  final String dayName;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final isSelected = state is EventChoose && state.id == id;

        return Container(
          width: 65,
          height: 90,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[600] : const Color(0xffF2F2F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 1),
              Text(
                monthName,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[350],
                  fontSize: 11,
                ),
              ),
              const Spacer(flex: 2),
              Text(
                dayNumber.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[350],
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Spacer(flex: 2),
              Text(
                dayName,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[350],
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        );
      },
    );
  }
}
