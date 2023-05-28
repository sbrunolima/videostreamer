import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/user.dart';

class UserPovider with ChangeNotifier {
  List<UserData> _user = [];

  List<UserData> get user {
    return [..._user];
  }

  //Load all users from firebase
  Future<void> loadUsers() async {

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      final List<UserData> loadedUsers = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (userID, userData) {
          loadedUsers.add(
            UserData(
              id: userID,
              userID: userData['userID'].toString(),
              email: userData['email'].toString(),
              username: userData['username'].toString(),
              imageUrl: userData['imageUrl'].toString(),
            ),
          );
        },
      );

      _user = loadedUsers.toList();

      notifyListeners();
    } catch (error) {
      print('ERRO USER=> $error');
    }
  }

  //Add new user to firebase
  Future<void> addUser(
    String userID,
    String email,
    String username,
    String imageUrl,
  ) async {

    await http.post(
      url,
      body: json.encode(
        {
          'userID': userID,
          'email': email,
          'username': username,
          'imageUrl': imageUrl,
        },
      ),
    );
  }

  //Edit user data on firebase
  Future<void> editUser({
    required String id,
    required String email,
    required String imageUrl,
    required String userID,
    required String username,
  }) async {
    final userIndex = _user.indexWhere((user) => user.id == id);

    if (userIndex >= 0) {

      await http.patch(
        url,
        body: json.encode(
          {
            'userID': userID,
            'email': email,
            'username': username,
            'imageUrl': imageUrl,
          },
        ),
      );

      notifyListeners();
    } else {
      print('Error editing user');
    }
  }
}
