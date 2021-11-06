enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      AuthStatus.authenticated;
    } catch (e) {
      AuthStatus.unauthenticated;
    }
  }

  void logout() async {
    AuthStatus.unauthenticated;
  }
}
