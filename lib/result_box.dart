import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({super.key, required this.result, required this.questionLength,required this.onPressed});

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Score",
            style: TextStyle(fontSize: 25, color: neutral,),),
            const SizedBox(height: 20,),
            CircleAvatar(
              radius: 60,
              backgroundColor: result == questionLength ? correct
              : result <questionLength/2 ? incorrect
              :result == questionLength/2 ? Colors.yellow[500] : Colors.blue,
              child:  Text("$result/$questionLength", style: const TextStyle(color: neutral, fontSize: 30, fontWeight: FontWeight.bold),),
             
            ),
            const SizedBox(height: 10,),
            Text(
              result <questionLength/2 ? "Try Again"
              :result == questionLength/2 ? "Almost there" : "Great",
              style: const TextStyle( fontSize: 25, color: neutral, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                return onPressed();
              },
              child: const Text('Start Over',
              style: TextStyle(
                fontSize: 25,
                 color: Colors.blue,
                 fontWeight: FontWeight.bold,
                 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}