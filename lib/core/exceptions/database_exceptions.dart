class DatabaseExceptions implements Exception {
  final String message;

  DatabaseExceptions(this.message);

  @override
  String toString() {
    return message;
  }
}

class ItemNotFoundException extends DatabaseExceptions {
  ItemNotFoundException() : super('Item not found in database');
}