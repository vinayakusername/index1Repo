import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



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

  Dialog showDateTimeDialog(BuildContext context,{@required ValueChanged<DateTime> onSelectedDate,
                               @required DateTime initialDate})
  {
     final dialog = Dialog
                     (
                       child: Container
                       (
                         height: 210,
                         child: DateTimeDialog
                         (
                           onSelectedDate: onSelectedDate,
                           initialDate:initialDate
                         ),
                       )
                     );
    showDialog(context: context,builder:(BuildContext context) => dialog);
  }

class DateTimeDialog extends StatefulWidget {

  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;

  DateTimeDialog({@required this.onSelectedDate,@required  this.initialDate});

  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {

  DateTime selectedDate;

  @override
  void initState()
  {
     selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Center
    (
      child: Padding
      (
        padding: const EdgeInsets.all(36.0),
        
          child: Column
          (
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
             children: <Widget>
             [
               Text('Select Date And Time',style:Theme.of(context).textTheme.title),
               SizedBox(height: 16.0,),
               Row
               (
                  children: <Widget>
                  [
                    RaisedButton
                    (
                      child: Text
                      (
                        DateFormat('yyyy-MM-dd').format(selectedDate),
                        style: TextStyle(color:Colors.white),
                      ),
                      color: Colors.pink,
                      onPressed:()async
                      {
                        final date = await _selectDateTime(context);
                        if(date==null) return;
                        print(date);

                        setState(() 
                        {
                          this.selectedDate = DateTime
                                              (
                                                date.year,
                                                date.month,
                                                date.day,
                                                selectedDate.hour,
                                                selectedDate.minute
                                              );

                        });

                        widget.onSelectedDate(selectedDate);
                      }
                    ),
                    SizedBox(width:8.0),
                    RaisedButton
                    (
                      child: Text
                      (
                        DateFormat('HH:mm').format(selectedDate),
                        style: TextStyle(color:Colors.white),
                      ),
                      color: Colors.pink,
                      onPressed:()async
                      {
                        final time = await _selectTime(context);
                        if(time==null) return;
                        print(time);

                         setState(() 
                        {
                          this.selectedDate = DateTime
                                              (
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                time.hour,
                                                time.minute
                                              );

                        });
                      widget.onSelectedDate(selectedDate);
                      }
                    )
                  ],
               ),
               OutlineButton
               (
                 child: Text('Schedule',style: TextStyle(fontSize: 15.0,color:Colors.pink),),
                 onPressed:()=> Navigator.of(context).pop(),
                 highlightColor: Colors.pink,
               ),
             ],  
          ),
      ),
    );
  }
}

// class NotificationDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container
//     (
      
//     );
//   }
// }