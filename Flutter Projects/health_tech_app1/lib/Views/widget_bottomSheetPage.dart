import 'package:flutter/material.dart';
import 'package:health_tech_app1/Views/widget_notificationDialog.dart';
import 'package:intl/intl.dart';

class BottomSheetPage extends StatefulWidget {
  @override
  _BottomSheetPageState createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {


   DateTime selectedDate = DateTime.now();
   final DateFormat dateFormat = DateFormat('yyyy-MM-dd  HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Bottom Sheet'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: <Widget>
        [
          IconButton
          (
            icon: Icon(Icons.settings), 
            onPressed: ()
            {
              // showModalBottomSheet
              //  (
              //    context: context,
              //    isScrollControlled: true, 
              //    builder:(context)=> _singleChildScrollWidget(context)
              //  ); 
              popUpDialod(context); 
            }
          )
        ],
      ),
      body: Center(child: Text('Bottom Sheet Example'))
    );
  }

  popUpDialod(BuildContext context)
  {
       return showDialog
       (
         context: context,
         barrierDismissible: false,
         builder: (BuildContext context)
         {
           return AlertDialog
           (
             title: Text
             (
               'Choose Preferred Action',
               style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),
               textAlign: TextAlign.center,
             ),
             content: Container
             (
               height: 96.0,
               decoration: BoxDecoration
               (
                 color: Colors.white,
                 borderRadius: BorderRadius.all
                 (
                   Radius.circular(35.0)
                 ),
               ),
               child: Column
               (
                 children: <Widget>
                 [
                  FlatButton
                  (
                    onPressed:()=>  Navigator.of(context).pop(), 
                    child: Text
                    (
                      'Watch Now', 
                      style: TextStyle(fontSize: 18.0,color:Colors.pink,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center
                    ),
                  ),
                  FlatButton
                  (
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                      showModalBottomSheet
                       (
                         context: context,
                         isScrollControlled: true, 
                         builder:(context)=> _singleChildScrollWidget(context)
                       ); 
                     
                    }, 
                    child: Text
                    (
                      'Reminder',
                      style: TextStyle(fontSize: 18.0,color:Colors.pink,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  )
                 ],
               ),
             ),
             actions: <Widget>
             [
               FlatButton
               (
                 child: Text('Cancel',style: TextStyle(color:Colors.white),),
                 textColor: Colors.pink,
                 color: Colors.pink,
                 onPressed: ()
                 {
                   Navigator.of(context).pop();
                 },
               )
             ],
           );
         }
       );
  }
  

  Widget _singleChildScrollWidget(BuildContext context)
  {
    return SingleChildScrollView
                 (
                   child: Container
                   (
                     padding: EdgeInsets.only
                     (
                       bottom:MediaQuery.of(context).viewInsets.bottom
                     ),
                     child: _bottomSheetContainer(context),
                   ),
                 );
  }
     
  

  Widget _bottomSheetContainer(BuildContext context)
  {
    return Container
      (
        color:Color(0xff757575),
        child: Container
        (
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration
          (
            color: Colors.white,
            borderRadius: BorderRadius.only
            (
              topLeft:Radius.circular(20.0) ,
              topRight:Radius.circular(20.0)
            ),
          ),
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              Text
              (
                'Reminder',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize:20.0,color: Colors.pink,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0,),
              // TextField
              // (
              //   autofocus: true,
              //   autocorrect: true,
              //   textAlign: TextAlign.center,
              //   onChanged: (value){},
              // ),
              Text
              (
                dateFormat.format(selectedDate),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize:20.0,fontWeight: FontWeight.bold),
              ),
              SizedBox(height:6.0),
              FlatButton
              (
                onPressed:() async
                {
                  Navigator.of(context).pop();
                   _dateTimePicker(); 
                }, 
                child: Text
                (
                'Choose Date And Time',
                style: TextStyle(fontSize: 16.0,color: Colors.white),
                textAlign: TextAlign.center,
                ),
                color: Colors.pink,
              ),
              FlatButton
              (
                onPressed:()=> Navigator.of(context).pop(), 
                child: Text
                (
                'Close',
                style: TextStyle(fontSize: 16.0,color: Colors.white),
                textAlign: TextAlign.center,
                ),
                color: Colors.pink,
              ),
            ],
          ),
        ),
      );
  }

  Widget _dateTimePicker()
  {
    return showDateTimeDialog(context, initialDate:selectedDate, onSelectedDate: (selectedDate)
              {
                setState(() 
                {
                    this.selectedDate = selectedDate;  
                });
              });
  }
}