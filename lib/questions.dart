class Questions
{
  //Questions
  final String title;

  //id of the questions
  final String id;

  //list of options with true and false values
  final Map<String, bool> options;
  Questions({
    required this.title,
    required this.id,
    required this.options,
  });

  @override
  String toString(){
    return 'Questions(id: $id, title: $title, options: $options)';

  }

  
}