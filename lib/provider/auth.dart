import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/local_storage_service.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/auth_service.dart';
import 'package:my_perpus/service/user_service.dart';

import '../setup_locator.dart';

class AuthProvider extends ChangeNotifier{
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  late UserModel user;
  var storageService = locator<LocalStorageService>();

  Future<Either<String, bool>> doSignIn({
    required String email, required String password
  })async{
    try{
      user = await _authService.signIn(email: email, password: password);
      storageService.saveToPref(Constants.role, user.role);
      storageService.saveToPref(Constants.userModel,jsonEncode(user.toJson()));
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> doSignUp({
    required UserModel user,
    required File userProfile,
  })async{
    try{
      user = await _authService.signUp(user,userProfile);
      this.user = user;

      storageService.saveToPref(Constants.role, user.role);
      storageService.saveToPref(Constants.userModel,jsonEncode(user.toJson()));
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  userIsOrderBook(){
    this.user.isOrder = true;
    notifyListeners();
  }

  setUserModelFromPref(UserModel user){
    this.user = user;
    notifyListeners();
  }

  Future<Either<String,bool>> doUpdateProfile(UserModel userModel)async{
    try{
      user = userModel;
      await _userService.updateProfile(userModel);
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }

  }

  Future<Either<String,bool>> doSignOut()async{
    try{
     await _authService.signOut();
     storageService.clearPref();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}