class GetDate {
  final int day;
  final int month;
  final int weekDay;
  GetDate({
    required this.day,
    required this.month,
    required this.weekDay,
  });

  String date() {
    String toDay = '';
    String toMonth = '';

    switch (month) {
      case 1:
        toMonth = "January";
        break;
      case 2:
        toMonth = "February";
        break;
      case 3:
        toMonth = "March";
        break;
      case 4:
        toMonth = "April";
        break;
      case 5:
        toMonth = "May";
        break;
      case 6:
        toMonth = "June";
        break;
      case 7:
        toMonth = "July";
        break;
      case 8:
        toMonth = "August";
        break;
      case 9:
        toMonth = "September";
        break;
      case 10:
        toMonth = "October";
        break;
      case 11:
        toMonth = "November";
        break;
      case 12:
        toMonth = "December";
        break;
    }

    switch (weekDay) {
      case 1:
        toDay = "Monday";
        break;
      case 2:
        toDay = "Tuesday";
        break;
      case 3:
        toDay = "Wednesday";
        break;
      case 4:
        toDay = "Thursday";
        break;
      case 5:
        toDay = "Friday";
        break;
      case 6:
        toDay = "Saturday";
        break;
      case 7:
        toDay = "Sunday";
        break;
    }
    return '$day $toMonth,$toDay';
  }
}
