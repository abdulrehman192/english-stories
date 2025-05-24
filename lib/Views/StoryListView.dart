import '/Constants/AppColors.dart';
import '/Controllers/StoryController.dart';
import '/Controllers/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Models/StoryModel.dart';
import '../Widgets/StoryCard.dart';
class StoryListView extends StatelessWidget {
  final Color cardBackgroundColor;
  final String title;
  const StoryListView({Key? key, required this.cardBackgroundColor, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (theme) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
            title: Text(title, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
            actions: [
              IconButton(
                onPressed: ()
                {
                  theme.isDark = !theme.isDark;
                },
                icon: const Icon(Icons.brightness_4,color: Colors.white,),
              ),
            ],
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark,

            ),
          ),
          body: GetBuilder<StoryController>(
            builder: (controller) {
              return ListView.builder(
                  itemCount: controller.filteredStories.length,
                  itemBuilder: (context, index){
                    return StoryCard(
                        story: controller.filteredStories[index],
                        backgroundColor: theme.isDark ? AppColors.darkContainerColor : cardBackgroundColor
                    );
                  }
              );
            }
          ),
        );
      }
    );
  }
}
