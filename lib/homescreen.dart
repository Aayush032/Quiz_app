import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/db_connect.dart';
import 'package:quiz_app/option_card.dart';
import 'package:quiz_app/question_widgets.dart';
import 'package:quiz_app/questions.dart';
import 'package:quiz_app/next_button.dart';
import 'package:quiz_app/result_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index =0;
  bool isPressed = false;
  int score = 0;
  bool isAlreadySelected = false;
  void checkAnswerAndUpdate(bool value){
    if(isAlreadySelected)
    {
      return ;
    }
    else{
       if(value == true)
      {
         score++;
      }
       setState(() {
         isPressed = true;
          isAlreadySelected= true;
    });
    }
    }
  void nextQuestion(int questionLength){
    if(index == questionLength-1)
    {
      showDialog(
        context: context,
        //this will disable the touch outside the box
        barrierDismissible: false,
         builder: (context) =>  ResultBox(
        questionLength: questionLength, 
        result: score,
        onPressed: startOver,
      ));
    }
    else{
      if(isPressed)
      {
      setState(() {
      index++;
      isPressed = false;
      isAlreadySelected = false;
    });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option') ,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),));
      }

    }
  }
  void startOver(){
    setState(() {
      index = 0;
      score = 0;
      isAlreadySelected = false;
      isPressed = false;
    });
    Navigator.pop(context);
  }
  var db = DBconnect();
  // final List<Questions> _questions =[
  //   Questions(
  //     title: 'What is 10+10',
  //     id: '1',
  //     options: {'100': false, '20':true, '0':false, '50':false},),
  //     Questions(
  //       title: 'What is 10X10', 
  //       id: '2',
  //        options: {'100': true, '20':false, '0':false, '50':false},
  //        ),
  // ];
  late Future _questions;
  Future<List<Questions>> getData() async {
    return db.fetchQuestion();

  }
  @override
  void initState() {
    _questions = getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Questions>>,
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"),);
          }
          else if(snapshot.hasData){
            var extractData = snapshot.data as List<Questions>;
            return  Scaffold(
               appBar: AppBar(
          title: const Text('Quiz App',
           style: TextStyle(
            fontSize: 25,
             color: Colors.amber,
             ),
             ),
             leading: IconButton(icon: const Icon(Icons.arrow_back), 
             onPressed: () {
              if(index==0)
              {
                return;
              }
              else{
                 setState(() {
                  index--;
                });
              }
               },),
          backgroundColor: background,
          shadowColor: Colors.transparent,
          actions: [Padding(padding: const EdgeInsets.only(top: 20, right: 15),
          child: Text("Score: $score",
          style: const TextStyle(fontSize: 25,color: neutral),),
          )],
        ),
        backgroundColor: background,
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                QuestionWidget(
                  question: extractData[index].title,
                   indexaction: index,
                    totalquestions: extractData.length,
                    ),
                    const Divider(
                      color: neutral,
                      thickness: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for(int i=0; i<extractData[index].options.length; i++)
                        GestureDetector(
                         onTap: () => checkAnswerAndUpdate( extractData[index].options.values.toList()[i]),
                          child: OptionCard(
                            options: extractData[index].options.keys.toList()[i],
                              color:  isPressed ? extractData[index].options.values.toList()[i] == true ?
                                 correct : 
                                 incorrect :
                                  neutral,
                          ),
                        ),
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () => nextQuestion(extractData.length),
          child:const  NextButton(
          ),
        ),
    
      );
          }
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),

          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
     
    );
  }
}