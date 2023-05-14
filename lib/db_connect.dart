import 'package:http/http.dart' as http;
import 'package:quiz_app/questions.dart';
import 'dart:convert';
class DBconnect{
final url = Uri.parse('https://quizapp-9067-default-rtdb.firebaseio.com/questions.json');
  Future<void> addQuestion(Questions question ) async{
      http.post(url,
      body: json.encode(
        {
          'title': question.title,
          'options':question.options,
        }
      )
      );
  }
  Future<List<Questions>> fetchQuestion() async{
    return http.get(url).then((response)
    {
      var data = json.decode(response.body) as Map<String,dynamic>;
      List<Questions> storeQuestion = [];
      data.forEach((key,value){
        var newQuestion = Questions(
          title: value['title'],
           id: key,
            options: Map.castFrom(value['options']),
            );
            storeQuestion.add(newQuestion);
      });
      return storeQuestion;
    });
  }
}