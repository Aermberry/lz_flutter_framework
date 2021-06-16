import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter_app/security/exception/social_login_exception.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@injectable
class SocialLoginService {

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if(googleUser == null){
      throw SocialLoginException(SocialLoginExceptionCode.loginWithGoogleError,'sign with google wrong');
    }
    return googleUser.id;
  }

  Future<String> signInWithApple() async {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      return credential.userIdentifier!;
  }

}
