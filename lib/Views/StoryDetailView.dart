import 'package:englishstories/Constants/AppColors.dart';
import 'package:englishstories/Controllers/TextToSpeechController.dart';
import 'package:englishstories/Controllers/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Constants/AppAssets.dart';
import '../Controllers/StoryController.dart';
import '../Models/StoryModel.dart';
class StoryDetailView extends StatefulWidget {
  final Story story;
  const StoryDetailView({Key? key, required this.story}) : super(key: key);

  @override
  State<StoryDetailView> createState() => _StoryDetailViewState();
}

class _StoryDetailViewState extends State<StoryDetailView> {

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 10
  );
  bool _isCollapsed = false;
  @override
  void initState() {
    super.initState();
    StoryController s = Get.find();
    s.story = widget.story;
    _scrollController.addListener(() {
      if(_scrollController.offset > kToolbarHeight)
        {
          _isCollapsed = true;
        }
      else
        {
          _isCollapsed = false;
        }
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: GetBuilder<ThemeController>(
        builder: (theme) {
          SystemChrome.setSystemUIOverlayStyle(
               SystemUiOverlayStyle(
            statusBarColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
          ));
          return Scaffold(
            backgroundColor: theme.isDark ? AppColors.darkContainerColor :AppColors.primaryColor,
            body: GetBuilder<StoryController>(
              builder: (controller) {
                return Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
                            systemNavigationBarColor: Colors.transparent,
                            statusBarIconBrightness: Brightness.light,
                            systemNavigationBarIconBrightness: Brightness.dark,

                          ),
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding: (_scrollController.positions.isNotEmpty) && _scrollController.offset >= 144 ? EdgeInsets.only(left: 50.w, bottom: 15.h) : EdgeInsets.zero,
                            title: (_scrollController.positions.isNotEmpty) && _scrollController.offset >= 144 ? Padding(
                              padding:  EdgeInsets.only(right: 50.w),
                              child: Text('${controller.story.title}', overflow: TextOverflow.ellipsis,),
                            ) :

                            Padding(
                              padding: _isCollapsed == false ? EdgeInsets.only(bottom: 30.h) : EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        controller.previousStory();
                                      },
                                      splashRadius: 20,
                                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 16.w,)
                                  ),
                                  Expanded(
                                      child: Text('${controller.story.title}',style: TextStyle(fontSize: _isCollapsed ? 15.sp : 13.sp, fontWeight: FontWeight.w500), )
                                  ),
                                  ( _scrollController.positions.isNotEmpty && _scrollController.offset >= 144 )? const SizedBox.shrink() :
                                  IconButton(
                                      onPressed: (){
                                        controller.nextStory();
                                      },
                                      splashRadius: 20,
                                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.w,)
                                  )
                                ],
                              ),
                            ),
                            background: Container(
                              width: 1.sw,
                              height: 150.h,
                              decoration: const BoxDecoration(
                                  image:  DecorationImage(
                                      image:  AssetImage(AppAssets.kidsStoriesImage),
                                      fit: BoxFit.cover,
                                      opacity: 0.6
                                  )
                              ),
                            ),
                          ),
                          expandedHeight: 200,
                          actions: [
                            IconButton(onPressed: (){
                              theme.isDark = !theme.isDark;
                            }, icon: const Icon(Icons.brightness_4,color: Colors.white,))
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
                            margin: EdgeInsets.all(10.sp),
                            width: double.infinity,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: theme.isDark ? AppColors.darkColor : Colors.white,
                            ),
                            child:  Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText("${controller.story.title}", style: TextStyle(fontSize: controller.storyFontSize)),
                                  SizedBox(height: 15.h,),
                                  SelectableText("${controller.story.story}", style: TextStyle(fontSize: controller.storyFontSize)),
                                  SizedBox(height: 15.h,),
                                  controller.story.moral.toString().isEmpty ? const SizedBox():
                                  SelectableText("Moral: ${controller.story.moral}", style: TextStyle(fontSize: controller.storyFontSize)),
                                ],
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                    _isCollapsed && _scrollController.offset > 10 ? const SizedBox.shrink():
                        Positioned(
                          right: 25.w,
                          top:  170.h,
                          child: GestureDetector(
                            onTap: (){
                              controller.toggleBookmark(controller.story);

                            },
                            child: CircleAvatar(
                              radius: 25.w,
                              child: Icon(controller.isBookMarked(controller.story) ? Icons.bookmark : Icons.bookmark_border),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          top:  270.h,
                          child: GestureDetector(
                            onTap: (){
                              controller.increaseStoryFont();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.shade200,
                              radius: 20.w,
                              child: const Icon(Icons.zoom_in,size: 30,color: Colors.white,),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          top:  330.h,
                          child: GestureDetector(
                            onTap: (){
                              controller.decreaseStoryFont();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent.shade100,
                              radius: 20.w,
                              child: const Icon(Icons.zoom_out,size: 30,color: Colors.white,),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   right: 10.w,
                        //   top:  390.h,
                        //   child: GestureDetector(
                        //     onTap: (){
                        //
                        //     },
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.blue,
                        //       radius: 20.w,
                        //       child: const Icon(Icons.translate,size: 30,color: Colors.white,),
                        //     ),
                        //   ),
                        // ),
                    Positioned(
                      right: 10.w,
                      top:  450.h,
                      child: GetBuilder<TextToSpeechController>(
                        builder: (speech) {
                          return GestureDetector(
                            onTap: (){
                              speech.textToSpeechUk("${controller.story.title} ${controller.story.story} ${controller.story.moral}");
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20.w,
                              child: speech.play == false ? const Icon(Icons.play_arrow,size: 30,color: Colors.white,): const Icon(Icons.pause,color: Colors.white,)
                            ),
                          );
                        }
                      ),
                    ),

                  ],
                );
              }
            )
          );
        }
      ),
    );
  }
}
