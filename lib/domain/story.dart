class Story {
  late String _title;
  late String _user;
  late DateTime _dateTime;
  late String _youtubeLink;
  late String _img;
  late String _message;
  late String _trackName;
  late String _artist;
  late String _location;

  Story(this._title, this._user, this._dateTime, this._youtubeLink, this._img,
      this._message, this._trackName, this._artist, this._location);

  String get title => _title;
  String get user => _user;
  DateTime get dateTime => _dateTime;
  String get link => _youtubeLink;
  String get img => _img;
  String get msg => _message;
  String get track => _trackName;
  String get artist => _artist;
  String get location => _location;
}