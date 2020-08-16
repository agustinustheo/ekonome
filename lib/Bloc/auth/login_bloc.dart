import 'package:EkonoMe/services/auth_service.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {
  final AuthService service;

  Stream<bool> _isVerified = Stream.empty();
  PublishSubject<List<String>> _credentials = PublishSubject<List<String>>();

  Stream<bool> get isVerified {
    return this._isVerified;
  }

  Sink<List<String>> get credentials {
    return this._credentials;
  }

  LoginBloc(this.service) {
    this._isVerified =
        this._credentials.asyncMap(this.service.signIn).asBroadcastStream();
  }

  void dispose() {
    _credentials.close();
  }
}
