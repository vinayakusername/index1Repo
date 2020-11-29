import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {

  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd  HH:mm');


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
       appBar: AppBar
       (
         title: Text('Date And Time Picker Demo'),
         centerTitle: true,
         backgroundColor: Colors.pink,
       ),
       body: _dateTimePickerButton(context),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context)
  {
       return showDatePicker
        (
          context: context, 
          initialDate: DateTime.now().add(Duration(seconds: 1)), 
          firstDate: DateTime.now(), 
          lastDate: DateTime(2100)
        );
  }

Future<TimeOfDay> _selectTime(BuildContext context)
  {
    final now  = DateTime.now();

  return  showTimePicker
          (
            context: context, 
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute)
          );
 
  }

  Widget _dateTimePickerButton(BuildContext context)
  {
    return Column
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>
      [

       Text(dateFormat.format(selectedDate)), 
       RaisedButton
      (
        child: Text('Choose Date And Time'),
        onPressed: () async
        {
          final selectedDate = await _selectDateTime(context);
          if(selectedDate == null) return;
          print('Selected Date is '+ selectedDate.toString());

          final selectedTime = await _selectTime(context);
          print('Selected Time is '+ selectedTime.toString());

          setState(() 
          {
              this.selectedDate = DateTime
                          (
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute
                          );       
          });         
        }
      ),
      ]
    );
  }
}