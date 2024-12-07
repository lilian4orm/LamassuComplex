

// class NavBarProvider with ChangeNotifier {
//   bool isCreateEvent = false;
//   int _selectedIndex = 0;
//   bool _isShowNavigationBar = true;
//   List<Widget> pages = [
//      HomeScreen(),
//      SearchScreen(),
//     HomeScreen(),
//     SearchScreen(),
//     const ProfileScreen(),
//   ];
//
//   Widget get selectedPage => pages[_selectedIndex];
//
//   int get selectedIndex => _selectedIndex;
//
//   bool get isShowNavigationBar => _isShowNavigationBar;
//
//   updateStateShowNavBar(bool value) {
//     _isShowNavigationBar = value;
//     notifyListeners();
//   }
//
//   void onItemTapped(int index) {
//     _selectedIndex = index;
//     notifyListeners();
//   }
//
//   String updateIcon(
//       {required int index,
//         required String icon,
//         required String selectedIcon}) {
//     return index == _selectedIndex ? selectedIcon : icon;
//   }
//
//   updateIsCreateEvent(bool value) {
//     isCreateEvent = value;
//     notifyListeners();
//   }
//
//   clearAll() {
//     isCreateEvent = false;
//     _selectedIndex = 0;
//     _isShowNavigationBar = true;
//   }
// }
