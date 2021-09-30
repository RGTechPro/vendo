
// It is like a list that contains named constant values
// image can be assessed by MediaType.image at index 0
import 'package:meta/meta.dart';
import 'package:vendo/models/StoryModels/user_model.dart'; // this contains the @required package


enum MediaType{
  image,
  video,
}


class Story{
  final String url; // it needs the url to the content that can be the video or imagen the photo or video is on that link
  final MediaType media; // for telling ourselves that it is a image or a video
  final Duration duration; // how long should it play
  final User user; // It will contain an instance of the user most probably


  const Story({
    required this.url,
    required this.media,
    required this.duration,
    required this.user
  });

}