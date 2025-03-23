class CartExceptions implements Exception {
  final String message;

  CartExceptions(this.message);

  @override
  String toString() {
    return message;
  }
}

class CartItemAlreadyExistsException extends CartExceptions {
  CartItemAlreadyExistsException() : super('Item already exists in cart');
}