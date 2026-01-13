import 'dart:io';

import 'package:application/common/repositories/GroupRepository.dart';
import 'package:application/features/registration/domain/entities/User.dart';
import 'package:application/features/registration/domain/repository/registerRepo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class RegisterReposytoryImp implements RegisterRepository {
  @override
  Future<User?> getUserGroup() async {
    var sharedData = await SharedPreferences.getInstance();
    String? group = sharedData.getString("user-group");
    return group == null ? null : User(group: group);
  }

  @override
  Future<bool> saveUserGroup(User user) async {
    var sharedData = await SharedPreferences.getInstance();

    return sharedData.setString("user-group", user.group);
  }


}
