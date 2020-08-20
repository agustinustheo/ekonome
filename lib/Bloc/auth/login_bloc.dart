import 'package:EkonoMe/helpers/auth_helper.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {
  final AuthHelper helper;

  Stream<bool> _isVerified = Stream.empty();
  PublishSubject<List<String>> _credentials = PublishSubject<List<String>>();

  Stream<bool> get isVerified {
    return this._isVerified;
  }

  Sink<List<String>> get credentials {
    return this._credentials;
  }

  LoginBloc(this.helper) {
    this._isVerified =
        this._credentials.asyncMap(this.helper.signIn).asBroadcastStream();
  }

  // Sementara pakai ini
  void login(List<String> creds) async {
    try {
      await this.helper.signIn(creds);
    } on Exception catch (ex) {
      print(ex);
    }
  }

  void dispose() {
    _credentials.close();
  }
}
