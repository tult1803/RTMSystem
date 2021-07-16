import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDatesBloc extends Cubit<DateTimeRange> {
  SelectDatesBloc(DateTimeRange dateTimeRange)
      : super(dateTimeRange);

  static DateTimeRange initDate() {
    DateTime dateTime = DateTime.now();
    return DateTimeRange(
      start: dateTime.subtract(Duration(days: 30)),
      end: dateTime,
    );
  }

  setDateTimeRange(DateTimeRange dateTimeRange) => emit(dateTimeRange);
}
