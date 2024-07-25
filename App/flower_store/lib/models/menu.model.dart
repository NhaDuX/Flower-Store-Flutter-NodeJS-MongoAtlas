class MenuItem {
  String label;
  List<MenuItem>? children;
  void Function()? onTap;
  
  MenuItem(this.label);
  MenuItem.haveChildren(this.label, this.children);
  MenuItem.withEven(this.label, this.children, this.onTap);
}