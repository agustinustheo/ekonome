import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:greenify/pages/auth/login.dart';
import 'package:greenify/util/session_util.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage>{
  String _userID = "", _userRef, _username, _fullname, _phone, _profilePictureUrl = "";
  bool _uploadingImage = false;

  var _usernameController = TextEditingController();
  var _fullnameController = TextEditingController();
  var _phoneController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Set initial state
  _EditProfileState() {
    getUserLogin().then((authId) => 
      getUserByAuthUID(authId).then((val) => setState((){
        _userID = authId;
        _userRef = val.documentID;
        if(val.data.containsKey('username')){
          _usernameController.text = val['username'];
          _fullnameController.text = val['fullname'];
          _phoneController.text = val['phone'];
        }
      }))
    );
  }

  @override
  Widget build(BuildContext context){
    // Image widget
    Widget _imageLoad(){
      if(_uploadingImage){
        return new Stack(
          children: <Widget>[
            new Opacity(
              opacity: 0.1,
              child:  Image.asset(
                'assets/graphics/user/anonymous.jpg',
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(50.0),
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ]
        );
      }
      else{
        if(_profilePictureUrl == ""){
          return new Image.asset(
            'assets/graphics/user/anonymous.jpg',
          );
        }
        else{
          return new FadeInImage(
            image: NetworkImage(_profilePictureUrl),
            placeholder: AssetImage('assets/graphics/user/anonymous.jpg'),
            fadeInDuration: Duration(milliseconds: 100),
            fadeOutDuration: Duration(milliseconds: 100),
          );
        }
      }
    }

    Widget _profilePicture(){
      return new GestureDetector(
          onTap: (){
            setState(() {
              _uploadingImage = true; 
            });
            _changeProfilePicture().then((_){
              setState(() {
                _uploadingImage = false; 
              });
            });
          },
          child: new Container(
            width: 150.0,
            padding: const EdgeInsets.only(
              top: 30.0, 
              bottom: 10.0, 
            ),
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(100.0),
              child: _imageLoad()
            )
          ),
        );
    }

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.center,
          child: new ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 5),
                    child: Container(
                      height: 65,
                      child: new Image.asset(
                          'assets/graphics/settings.png'),
                    ),
                  ),
                  new Container(
                    child: new StreamBuilder(
                      stream: Firestore.instance.collection('users').where("auth_uid", isEqualTo: _userID).snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.data != null){
                          if(snapshot.data.documents.length > 0){
                            if(snapshot.data.documents[0].data.containsKey('profile_pic_url')) 
                              _profilePictureUrl = snapshot.data.documents[0]['profile_pic_url'];
                          }
                        }
                        return _profilePicture();
                      }
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(
                      5.0,
                    ),
                    child: new SizedBox(
                      width: 275.0,
                      child: TextFormField(
                        controller: _usernameController,
                        cursorColor: Colors.white,
                        validator: (input){
                          if(input.isEmpty){
                            return 'Please type a username';
                          }
                        },
                        onSaved: (input) => _username = input,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: new SizedBox(
                      width: 275.0,
                      child: TextFormField(
                        controller: _fullnameController,
                        cursorColor: Colors.white,
                        validator: (input){
                          if(input.isEmpty){
                            return 'Please type your fullname';
                          }
                        },
                        onSaved: (input) => _fullname = input,
                        decoration: InputDecoration(
                          labelText: 'Fullname',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: new SizedBox(
                      width: 275.0,
                      child: TextFormField(
                        controller: _phoneController,
                        cursorColor: Colors.white,
                        validator: (input){
                          RegExp regExp = new RegExp(
                            r"^\+?([ -]?\d+)+|\(\d+\)([ -]\d+)",
                            caseSensitive: false,
                            multiLine: false,
                          );
                          if(input.isEmpty){
                            return 'Please provide your phone number';
                          }
                          else if(input.length < 8){
                            return 'A phone number must be more than 7 characters';
                          }
                          else if(!regExp.hasMatch(input)){
                            return 'Phone number is not valid';
                          }
                        },
                        onSaved: (input) => _phone = input,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(
                      5.0,
                    ),
                    child: new SizedBox(
                      width: 255.0,
                      child: RaisedButton(
                        onPressed: () => {
                          saveUserRecord().then((_){
                            setState(() {
                              _uploadingImage = false; 
                            });
                          }),
                        },
                        padding: EdgeInsets.all(13.0),
                        color: Colors.white,
                        child: Text(
                          'Save',
                          style: new TextStyle(
                            fontSize: 16.0, 
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(
                      5.0,
                    ),
                    child: new SizedBox(
                      width: 255.0,
                      child: RaisedButton(
                        onPressed: signOut,
                        padding: EdgeInsets.all(13.0),
                        color: Colors.white,
                        child: Text(
                          'Logout',
                          style: new TextStyle(
                            fontSize: 16.0, 
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeProfilePicture() async{
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    final _storage = FirebaseStorage(storageBucket: 'gs://greenify-89311.appspot.com');
    String downloadUrl = "";

    if(selected != null){
      selected = await ImageCropper.cropImage(
        ratioX: 1,
        ratioY: 1,
        sourcePath: selected.path,
        toolbarColor: Colors.white,
        toolbarWidgetColor: Colors.pink,
        statusBarColor: Colors.black,
        toolbarTitle: 'Crop Image'
      );
    }

    if(selected != null){
      DocumentSnapshot userData = await getUserByAuthUID(_userID);

      StorageUploadTask _uploadTask = _storage.ref().child('user_photos/${userData['username']}_${DateTime.now()}.jpg').putFile(selected);
      StorageTaskSnapshot _storageTaskSnapshot = await _uploadTask.onComplete;
      downloadUrl = await _storageTaskSnapshot.ref.getDownloadURL();

      Firestore.instance.collection("users").document(userData.documentID)
      .updateData({
          'profile_pic_url': downloadUrl,
        }
      );
    }
  }

  Future<void> saveUserRecord() async{
    final formState = _formKey.currentState;
    final databaseReference = Firestore.instance;

    if(formState.validate()){
      formState.save();

      try{
        Query userData = Firestore.instance.collection('users').where("username", isEqualTo: _username);
        QuerySnapshot userDataSnapshot = await userData.getDocuments();

        // Check if no document uses the same username
        // Or if the document that uses that document is the user itself
        if(
          userDataSnapshot.documents.isEmpty ||
          (userDataSnapshot.documents.length == 1 && userDataSnapshot.documents[0].documentID == _userRef)
        ){
          await databaseReference.collection("users").document(_userRef)
            .updateData({
              'username': _username,
              'fullname': _fullname,
              'phone': _phone,
            }
          );
          
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc:
                "Successfully updated profile!",
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
        else{
          Alert(
            context: context,
            type: AlertType.error,
            title: "Failed",
            desc:
                "Username has been used!\nPlease enter another one.",
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      }
      catch(e){
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc:
              "Error: " + e.message.toString(),
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }

  Future<void> signOut(){
    try{
      removeUserLogin();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    catch(e){
      print(e);
    }
  }
}