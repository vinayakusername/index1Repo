import 'package:flutter/material.dart';
import 'package:health_tech_app1/Views/widget_notificationDialog.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget1 extends StatefulWidget {
  @override
  _DateTimePickerWidget1State createState() => _DateTimePickerWidget1State();
}

class _DateTimePickerWidget1State extends State<DateTimePickerWidget1> {

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

 

  Widget _dateTimePickerButton(BuildContext context)
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 90.0,right: 90.0),
        child: Column
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
              showDateTimeDialog(context, initialDate:selectedDate, onSelectedDate: (selectedDate)
              {
                setState(() 
                {
                    this.selectedDate = selectedDate;  
                });
              });
            }
          ),
          ]
        ),
      ),
    );
  }
}