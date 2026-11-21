import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService.internal();

  static final AuthService _instance = AuthService.internal();

  factory AuthService() {
    return _instance;
  }

  // Mengakses Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Memantau perubahan status login
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // Registrasi akun baru
  Future<User?> signUp(
      String email,
      String password,
      ) async {
    try {
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Error Sign Up: ${e.code}');
      return null;
    }
  }

  // Login menggunakan akun terdaftar
  Future<User?> signIn(
      String email,
      String password,
      ) async {
    try {
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Error Sign In: ${e.code}');
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}