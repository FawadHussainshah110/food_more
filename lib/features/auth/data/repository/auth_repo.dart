import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';
import 'auth_repo_interface.dart';

class AuthRepo implements AuthRepoInterface {
  final FlutterSecureStorage storage;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  AuthRepo({required this.storage});

  @override
  Future<UserModel?> loginWithGoogle() async {
    await GoogleSignIn().signOut();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final user = UserModel(
          uid: googleUser.id,
          email: googleUser.email,
          name: googleUser.displayName ?? 'Google User',
          photoUrl: googleUser.photoUrl,
        );
        debugPrint('Google User: ${user.name} +++ Email: ${user.email} +++ UID: ${user.uid}');
        await _saveUserSession(user);
        return user;
      }
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      rethrow;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
    await storage.delete(key: 'user_session');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final String? session = await storage.read(key: 'user_session');
    if (session == null) return null;
    try {
      final Map<String, dynamic> data = jsonDecode(session);
      return UserModel(uid: data['uid'], email: data['email'], name: data['name'], photoUrl: data['photoUrl']);
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveUserSession(UserModel user) async {
    final Map<String, dynamic> data = {'uid': user.uid, 'email': user.email, 'name': user.name, 'photoUrl': user.photoUrl};
    await storage.write(key: 'user_session', value: jsonEncode(data));
  }
}
