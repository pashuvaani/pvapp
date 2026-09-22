
class CartItem {
  final String name;
  final String price;
  final String image;
  final int priceNum;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.priceNum,
    this.quantity = 1,
  });
}

class CartStore {
  // Simple global state for the mockup
  static final List<CartItem> items = [];
  
  static void addItem(CartItem item) {
    final existingIndex = items.indexWhere((i) => i.name == item.name);
    if (existingIndex >= 0) {
      items[existingIndex].quantity += item.quantity;
    } else {
      items.add(item);
    }
  }
  
  static void removeItem(int index) {
    items.removeAt(index);
  }
  
  static int getTotal() {
    int total = 0;
    for (var item in items) {
      total += (item.priceNum * item.quantity);
    }
    return total;
  }
  
  static void clear() {
    items.clear();
  }
}
