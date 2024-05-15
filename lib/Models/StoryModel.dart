class Story
{
  final int? id;
  final String? storyType;
  final String? title;
  final String? moral;
  final bool? favourite;
  final String? story;
  final String? imageUrl;

  Story({this.id, this.storyType,this.title,this.moral,this.favourite,this.story,this.imageUrl});

  factory Story.fromMap(Map data){
    return Story(
      id: data['id'],
      storyType: data['storyType'],
      title: data['title'],
      moral: data['moral'],
      favourite: data['favourite'] == 1 || data['favourite'] == true ? true : false,
      story: data['story'],
      imageUrl: data['imageUrl'],
    );
  }


}