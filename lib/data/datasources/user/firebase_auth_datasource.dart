import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<UserModel> registerWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  Future<UserModel> signInWithGoogle() async {
    // Bước 1: Đăng nhập bằng Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Đăng nhập bị hủy.');
    }

    // Bước 2: Lấy thông tin xác thực
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Bước 3: Tạo đối tượng UserCredential từ thông tin xác thực
    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ),
    );

    // Bước 4: Chuyển đổi UserCredential thành UserModel
    return UserModel.fromFirebaseUser(userCredential.user!);
  }
}