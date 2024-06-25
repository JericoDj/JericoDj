class CartService {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> item) {
    cartItems.add(item);
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }
}