// worker_model.dart

class AddedWorker {
  final String categoryBoxName;
  final int price;
  final int categoryIndex;
  final int selectedBoxIndex;
  final int quantity;
  final DateTime timestamp;

  AddedWorker({
    required this.categoryBoxName,
    required this.price,
    required this.categoryIndex,
    required this.selectedBoxIndex,
    required this.quantity,
    required this.timestamp,
  });
}
// You can add additional methods or properties as needed