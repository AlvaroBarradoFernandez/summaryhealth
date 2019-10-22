import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'User.dart';

///Aquí están todos los metodos relacionados con la Autorización del Usuario (Login)
///Logueo con Usuario y Contraseña
///Registro con Usuario y Contraseña
///Coger el Usuario Actual
///Login con Google
///Login con Facebook
///LogOut de Google
///LogOut de Facebook
///LogOut de Usuario Normal
///Los TODOS los uso como marcapáginas

abstract class AuthMethods {
  Future<FirebaseUser> singInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password, String username, String appelido1, String apellido2);
  Future<FirebaseUser> getCurrentUser();
  Future<User> setUserData(FirebaseUser user);
  Future<void> signOutNormalUser();

}

class Auth implements AuthMethods {
  User userData;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///TODO Login Aquí
  Future<FirebaseUser> singInWithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user;
     user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password).catchError((onError){

       print("Verify:" + user.isEmailVerified.toString());
          print(onError);

    })).user;
    return user;
  }

  ///TODO Registro Aquí

  Future<User> createUserWithEmailAndPassword(String email, String password, String username, String surname1, String surname2) async {
   FirebaseUser mUser = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      user.user.sendEmailVerification();
      userData = await setUserData(user.user);
      userData.email = email;
      userData.displayName = username;
      userData.surname1 = surname1;
      userData.surname2 = surname2;
      await createProfile(userData);

    }).catchError((e) {
      print(e);
    });
   print('Perfil id:' + mUser.uid);
    return userData;
  }


  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<User> setUserData(FirebaseUser user) async{
    userData = new User(userData.uid, userData.displayName, userData.photoUrl, userData.email, userData.surname1, userData.surname2);
    return userData;
  }


  ///Crea el Perfil de Usuario
  Future<void> createProfile(userData) async {

    Firestore.instance
        .collection('Perfiles')
        .document(userData.uid)
        .setData({
      "Nombre": userData.displayName,
      "Email": userData.email,
      "surname 1": userData.surname1,
      "surname 2": userData.surname2,


      //"ProfilePic": userData.photoUrl,
    }).catchError((e) {
      print(e);
    });

    print('Create Profile: ' + userData.uid);

    await getProfile(userData.uid);
  }

  ///Recoge el perfil del Usuario
  Future<User> getProfile(String uid) async {



    await Firestore.instance.collection('Perfiles')
        .document(uid).get().then((datasnapshot) {

      if (datasnapshot.exists) {
        userData.displayName =  datasnapshot.data['Nombre'];
        userData.email = datasnapshot.data['Email'];
        userData.surname1 = datasnapshot.data['surname 1'];
        userData.surname2 = datasnapshot.data['surname 2'];




      }
    }).catchError((e) {
      print(e);
    });


    return userData;
  }

  ///LogOut de Usuario Normal
  Future<void> signOutNormalUser() async {
    await _firebaseAuth.signOut();
  }


}