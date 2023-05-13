// create model for question
// create a simple class

class CategoryQuestion {
  //define on how a category will look like here
  //every category will have an id
  final String id;
  //every category will have an section
  final String section;
  //every category will have their own category
  final String name;

  //create a constructor
  CategoryQuestion({
    required this.id,
    required this.section,
    required this.name,
  });

  //override the toString method to print questions on console
  @override
  String toString() {
    // TODO: implement toString
    return 'Question(id: $id, category: $name, section: $section)';
  }
}
