import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendo/models/StoryModels/data.dart';
import 'package:vendo/models/StoryModels/story_model.dart';
import 'package:vendo/models/StoryModels/user_model.dart';
import 'package:video_player/video_player.dart';


class StoryScreen extends StatefulWidget {
  final List<Story> stories;
  int index;
  StoryScreen({required this.stories, required this.index});
  @override _StoryScreenState createState() =>_StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late VideoPlayerController _videoController;
  //int widget.index = 0;

  @override
  void initState(){
    super.initState();
    _pageController = PageController();  //initialize
    _animationController = AnimationController(vsync: this);  // it takes the duration for the animation as an arg

    final Story firstStory = widget.stories.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animationController.addStatusListener((status)  {  // this will return the status of the animation
      if(status==AnimationStatus.completed){
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if(widget.index + 1 <widget.stories.length) {
            widget.index +=1;
            _loadStory(story: widget.stories[widget.index]);
          } else {
            // Out of bounds
            widget.index = 0;
            _loadStory(story:widget.stories[widget.index]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    //_videoController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    print(stories);  // a list of instances of story
    final Story story = widget.stories[widget.index]; // it stores an instance of story class that is at the 0 index
    print(widget.stories[0].url);
    //print("thisisthat");
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown:(details) => _onTapDown(details, story),

        child :Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController, // this contains all the initial page in this case it will be an image
              itemCount: widget.stories.length,
              physics: NeverScrollableScrollPhysics(),  // this disables the scrolling of the app pages
              itemBuilder: (context,i)
              {
                final Story story = widget.stories[i];
                switch (story.media) {
                  case MediaType.image:
                    return
                      CachedNetworkImage(
                        placeholder: (context, url) => CircularProgressIndicator(),
                        imageUrl:story.url,
                        fit:BoxFit.cover,
                      );
                  case MediaType.video:
                    if(_videoController != null && _videoController.value.isInitialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      );
                    }
                }
                return const SizedBox.shrink();// switch case
              },),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10,
              child: Column(
                children:<Widget> [
                  Row(
                    children: widget.stories
                        .asMap()
                        .map((i, e){
                      return MapEntry(
                        i,
                        AnimatedBar(
                          animationController:_animationController,
                          position:i, // position of the story in the widget
                          currentIndex:widget.index,
                        ),
                      );
                    })
                        .values
                        .toList(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10,
                    ),
                    child: UserInfo(user: story.user,),

                  )
                ],
              ),
            )
          ],
        ),
      ),);

  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width; // total width of our device
    final double dx = details.globalPosition.dx; //x position of the tap location

    if(dx < screenWidth/3 ){ // checking if the user tapped on the first half of the screen beginning from the left
      setState(() {
        if(widget.index -1 >=0) {   //checking if the user is not on the first story then change it to previous one
          widget.index-=1;
          _loadStory(story: widget.stories[widget.index]);
        }
      });
    }
    else if (dx>2*screenWidth/3) { // checking if the user tapped on the last third part of the screen then change it
      setState(() {
        if(widget.index +1 <widget.stories.length) {
          widget.index +=1;
          _loadStory(story: widget.stories[widget.index]);
        } else{
          // Out of the bound that is if the user on the last story tapped on the last half of the screen
          widget.index = 0;
          _loadStory(story: widget.stories[widget.index]);
        }
      });
    }
    else { // we have covered the first third half and the last third half now this will be trigged if tapped on the center
      if(story.media == MediaType.video) {
        if(_videoController.value.isPlaying) {
          _videoController.pause();
          _animationController.stop();
        }
        else{
          _videoController.play();
          _animationController.forward();
        }
      }
    } //else
  } //onTapDown


  void _loadStory({required Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset(); // animation to the bar

    switch (story.media) {
      case MediaType.image:
        _animationController.duration = story.duration;
        _animationController.forward();  // this starts the animation
        break;
      case MediaType.video:
        //_videoController = null;
        //_videoController.dispose();
        _videoController = VideoPlayerController.network(story.url)
          ..initialize().then((_){
            setState(() {
              if(_videoController.value.isInitialized) {
                _animationController.duration = _videoController.value.duration;
                _videoController.play();
                _animationController.forward();
              }
            });
          });
        break;
    }

    if(animateToPage) {
      _pageController.animateToPage(
        widget.index,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}


class AnimatedBar extends StatelessWidget{
  final AnimationController animationController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key ?key,
    required this.animationController,
    required this.position,
    required this.currentIndex,
  })  : super(key : key);

  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return _buildContainer(
                      constraints.maxWidth * animationController.value,
                      Colors.white,
                    );
                  },
                )

                    : const SizedBox.shrink(),

              ],
            );
          },
        ),
      ),
    );
  }


  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

}

/*
class UserInfo extends StatelessWidget{
  final User user;
  const UserInfo({
    Key key,
    @required this.user,

  }) : super(key:key);
}*/

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    Key ?key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            user.profileImageUrl,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}