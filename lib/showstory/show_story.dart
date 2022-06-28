import 'package:dash_mement/poststory/post_image.dart';
import 'package:dash_mement/component/story/image_container.dart';
import 'package:dash_mement/style/mmnt_style.dart';
import 'package:dash_mement/style/story_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../providers/storylist_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

/* 
showStory는 유튜브 처음 링크 필요
나머지 데이터는 provider로 생성

Issue: story text 크기 제한
Issue: Appbar 안드로이드에서는 중앙정렬이 안됨
*/
class ShowStory extends StatefulWidget {
  late String _initialVideoLink;

  ShowStory(this._initialVideoLink);
  @override
  State<StatefulWidget> createState() {
    return _ShowStory();
  }
}

class _ShowStory extends State<ShowStory> {
  late StoryListProvider _storyList;
  List<ImageContainer> _storyWidgetList = [];
  late double _percent;
  int _currentValue = 1;

  //youtube
  List<String> _urlList = [];
  late YoutubePlayerController _youtubePlayerController;

  void _postStory() {
    _youtubePlayerController.pause();
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PostImage(_backFromChild)));
  }

  void _backButton() {}

  void _backFromChild() {
    _youtubePlayerController.play();
  }

  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId(widget._initialVideoLink) ?? "error",
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          loop: true,
        ));
    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _storyList = Provider.of<StoryListProvider>(context);

    //storywidget 생성 / urlList 생성
    _storyWidgetList = [];
    for (int i = 0; i < _storyList.getLength(); i++) {
      _storyWidgetList.add(ImageContainer.story(
          MediaQuery.of(context).size, _storyList.getStoryAt(i)));
      _urlList.add(
          YoutubePlayer.convertUrlToId(_storyList.getStoryAt(i).link) ?? "");
    }

    _percent = _currentValue / _storyList.getLength();

    return Scaffold(
      backgroundColor: MmntStyle().mainBlack,
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFFD9D9D9)),
            onPressed: () => _backButton(),
          ),
          backgroundColor: MmntStyle().mainBlack,
          shadowColor: Colors.transparent,
          title: Text("정릉동 #${_currentValue}",
              style: StoryTextStyle().appBarWhite)),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        builder: (context, player) => SafeArea(
            child: Stack(alignment: Alignment.center, children: [
          Positioned(child: player),
          Positioned(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            color: MmntStyle().mainBlack,
          )),
          CarouselSlider(
            items: _storyWidgetList,
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  _youtubePlayerController.load(_urlList[index]);
                  setState(() {
                    _currentValue = index + 1;
                  });
                },
                height: MediaQuery.of(context).size.height *
                    0.92, // carousel height
                enableInfiniteScroll: false, // 무한 스크롤
                autoPlay: false, // 자동 넘김
                viewportFraction: 0.9), // viewport
          ),
          // linear indicator
          Positioned(
              top: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: LinearProgressIndicator(
                    value: _percent,
                    backgroundColor: MmntStyle().secondBlack,
                    valueColor: new AlwaysStoppedAnimation(MmntStyle().second),
                  )))
        ])),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _postStory(),
          backgroundColor: MmntStyle().primary,
          child: Icon(
            Icons.add,
            color: MmntStyle().mainWhite,
          )),
    );
  }
}
