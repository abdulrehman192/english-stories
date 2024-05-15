class StoryType
{
  final String? storyType;
  final String? imageUrl;

  StoryType({this.storyType, this.imageUrl});

  factory StoryType.fromMap(Map data)
  {
    return StoryType(
      storyType: data['storyType'],
      imageUrl: data['imageUrl'],
    );
  }
}