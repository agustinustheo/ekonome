import 'package:EkonoMe/API/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc {
  final AuthService service;

  Stream<FirebaseUser> _createdUser = Stream.empty();
  PublishSubject<List<String>> _credentials = PublishSubject<List<String>>();

  Stream<FirebaseUser> get createdUser {
    return this._createdUser;
  }

  Sink<List<String>> get credentials {
    return this._credentials;
  }

  RegisterBloc(this.service) {
    this._createdUser =
        this._credentials.asyncMap(this.service.signUp).asBroadcastStream();
  }

  void dispose() {
    _credentials.close();
  }
}
