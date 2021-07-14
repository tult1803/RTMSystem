class AdvanceChecked {
  String id;
  int amount;
  bool isSelected;
  AdvanceChecked({this.id, this.amount, this.isSelected});
  
  String get getId => id;

  set setId(String value) {
    id = value;
  }

  int get getAmount => amount;

  set setAmount(int value) {
    amount = value;
  }

  bool get getIsSelected => isSelected;

  set setIsSelected(bool value) {
    isSelected = value;
  }

}
