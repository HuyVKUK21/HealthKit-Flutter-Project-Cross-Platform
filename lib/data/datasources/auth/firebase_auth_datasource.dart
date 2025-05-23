import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/models/account_model.dart';
import 'package:fitnessapp/data/models/user_model.dart';
import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuthDataSource(this._firebaseAuth);

  Future<UserModel> registerWithEmailAndPassword(
      String email,
      String password, {
        required String fullName,
        required String age,
        required String phone,
      }) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'userId': user.uid,
        'email': user.email,
        'fullName': fullName,
        'age': age,
        'phone': phone,
      });
    }

    return UserModel.fromFirebaseUser(user!);
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  Future<UserModel> signInWithGoogle() async {
    // Đăng nhập Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Đăng nhập bị hủy.');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ),
    );

    User? user = userCredential.user;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'userId': user.uid,
          'email': user.email,
          'fullName': user.displayName ?? 'No Name',
          'age': null,
          'phone': null,
        });
      }
      return UserModel.fromFirebaseUser(userCredential.user!);
    } else {
      throw Exception('Đăng nhập không thành công.');
    }
  }


  Future<AccountModel?> getInfoAccount(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        AccountModel accountModel = AccountModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return accountModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}