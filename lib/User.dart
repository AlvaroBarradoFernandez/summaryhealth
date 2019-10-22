class User {

  String _uid;
  String _displayName;
  String _photoUrl;
  String _email;
  String _surname1;
  String _surname2;



  User(this._uid, this._displayName, this._photoUrl,
      this._email, this._surname1, this._surname2);

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }


  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }

  String get photoUrl => _photoUrl;

  set photoUrl(String value) {
    _photoUrl = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get surname1 => _surname1;

  set surname1(String value) {
    _surname1 = value;
  }

  String get surname2 => _surname2;

  set surname2(String value) {
    _surname2 = value;
  }
}


