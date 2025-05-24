import '/Models/StoryType.dart';
import '/Services/Services.dart';
import '/Utills/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Models/StoryModel.dart';
import 'dart:math' as math;
class StoryController extends GetxController
{
List<Story> _stories =[];
List<StoryType> _types = [];
List<Story> _filteredStories =[];
List<Story> _bookmarkedStories =[];
List<Color> _colorsList = [];
bool loading = false;
 Story _story = Story();
double _storyFontSize = 18.sp;
String _selectedType = "Short Stories";
final db = SqliteService.instance;
//getters
List<Color> get colors => _colorsList;
List<Story> get stories => _stories;
List<StoryType> get types => _types;
List<Story> get filteredStories => _filteredStories;
List<Story> get bookmarkedStories => _bookmarkedStories;
String get selectedType => _selectedType;
double get storyFontSize => _storyFontSize;
Story get story => _story;

set story(Story val)
{
  _story = val;
  // update();
}

  set selectedType(String val)
  {
    _selectedType = val;
    _filteredStories = _stories.where((element) => element.storyType == _selectedType).toList();
    update();
  }

increaseStoryFont()
{
  if(_storyFontSize < 25){
    _storyFontSize++;
    update();
  }
}


  decreaseStoryFont()
  {
    if(_storyFontSize > 14){
      _storyFontSize--;
      update();
    }
  }
@override
  onInit(){
  super.onInit();
  _getStoryTypes();
  getStories();
}


_getStoryTypes() async{
  loading =true;
  update();
  var data = await db.getAllRows("Select storyType, imageUrl from stories group by storyType order by priority asc");
  _types = data.map((e) => StoryType.fromMap(e)).toList();
  _colorsList.clear();
  for(int i = 0; i < _types.length; i++)
    {
      _colorsList.add(Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8));
    }
  loading = false;
  update();
}

int _getStoryIndex(Story story)
{
  int x = -1;
  for(int i = 0; i < _stories.length; i++)
    {
      if(story.id == _stories[i].id)
          {
            x = i;
          }
    }
  return x;
}

toggleBookmark(Story story)async
{
  int index = _getStoryIndex(story);
  Story s = Story(
    id: _stories[index].id,
    storyType: _stories[index].storyType,
    title: _stories[index].title,
    moral: _stories[index].moral,
    story: _stories[index].story,
    imageUrl: _stories[index].imageUrl,
    favourite: _stories[index].favourite == true ? false : true
  );
  _stories[index] = s;
  String query = "Update stories set favourite = '${_stories[index].favourite == true ? 0 : 1}' where id = '${story.id}'";
  await db.update(query);
  await getBookMarkedStories();
  if(_stories[index].favourite == true)
    {
      CommonFunctions.showToast("Added to Bookmark");
    }
  else
    {
      CommonFunctions.showToast("Removed from Bookmark");
    }
  update();
}

bool isBookMarked(Story story)
{
  bool bookMarked = false;
  int index = _getStoryIndex(story);
  if(_stories[index].favourite == true)
    {
      bookMarked = true;
    }
  return bookMarked;
}

getStories() async
{
  loading =true;
  update();
 var data = await db.getAllRows("Select * from stories");
 _stories = data.map((e) => Story.fromMap(e)).toList();
 _filteredStories = _stories.where((element) => element.storyType == _selectedType).toList();
 getBookMarkedStories();
 loading = false;
 update();
}

  int _getFilteredStoryIndex(Story story)
  {
    int x = -1;
    for(int i = 0; i < _filteredStories.length; i++)
    {
      if(story.id == _filteredStories[i].id)
      {
        x = i;
      }
    }
    return x;
  }

  nextStory()
  {
    int index = _getFilteredStoryIndex(_story);

    if(index >= _filteredStories.length - 1)
      {
        CommonFunctions.showToast("This is last story");
      }
    else
      {
        _story = _filteredStories[index + 1];
        update();
      }
  }

  previousStory()
  {
    int index = _getFilteredStoryIndex(_story);
    if(index <= 0)
    {
      CommonFunctions.showToast("This is first story");
    }
    else
    {
      _story = _filteredStories[index - 1];
      update();
    }
  }


  getBookMarkedStories()
  {
    _bookmarkedStories = _stories.where((element) => element.favourite == true).toList();
    update();
  }

}