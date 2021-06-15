import 'dart:io';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain quizBrain=QuizBrain();
void main() {
  runApp(
    /// 1. Wrap your App widget in the Phoenix widget
    Phoenix(
      child: Quizzler(),
    ),
  );
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

   List<Widget> checker=[
   //  Icon(Icons.check_circle_rounded,color: Colors.greenAccent,),

  ];
   void checkanswer(bool userpickedanswer)
   { if(quizBrain.getquestionno()+1>quizBrain.getbanklen()-1)
     {
       Alert(
         context: context,
         type: AlertType.warning,
         title: "RFLUTTER ALERT",
         desc: "Flutter is more awesome with RFlutter Alert.",
         buttons: [
           DialogButton(
             child: Text(
               "RESET",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: (){
                             Phoenix.rebirth(context);
                           },
             color: Color.fromRGBO(0, 179, 134, 1.0),
           ),
           DialogButton(
             child: Text(
               "EXIT",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: () {
               exit(0);
             },
             gradient: LinearGradient(colors: [
               Color.fromRGBO(116, 116, 191, 1.0),
               Color.fromRGBO(52, 138, 199, 1.0)
             ]),
           )
         ],
       ).show();
     }
     setState(() {

     bool currentanswer = quizBrain.getanswer();
     if (currentanswer == true)
       checker.add(
           Icon(Icons.check_circle_rounded, color: Colors.green));
     else
       checker.add(
           Icon(Icons.check_circle_rounded, color: Colors.red));



       quizBrain.nextquestion();

     });

   }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
              quizBrain.getquestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {

                  checkanswer(true);

                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {

                  checkanswer(false);

                //The user picked false.
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Expanded(
          child: Row(
            children:checker,
          ),
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

