class AuthException implements Exception {
  final String message;

  const AuthException(this.message);
}

class IncompleteProfileException extends AuthException {
  const IncompleteProfileException() : super('Please complete your profile');
}
