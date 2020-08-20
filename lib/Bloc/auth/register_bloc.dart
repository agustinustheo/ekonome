import 'package:EkonoMe/helpers/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc {
  final AuthHelper helper;

  Stream<FirebaseUser> _createdUser = Stream.empty();
  PublishSubject<List<String>> _credentials = PublishSubject<List<String>>();

  Stream<FirebaseUser> get createdUser {
    return this._createdUser;
  }

  Sink<List<String>> get credentials {
    return this._credentials;
  }
  
  RegisterBloc(this.helper){
    this._createdUser =
        this._credentials.asyncMap(this.helper.signUp).asBroadcastStream();
  }

  // Sementara pakai ini
  void register(List<String> creds) async{
    try {
      await this.helper.signUp(creds);
    } catch (ex) {
      throw ex;
    }
  }

  void dispose() {
    _credentials.close();
  }
}
