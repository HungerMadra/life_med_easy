class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  // Add your state variables here
  
  //Pop Up One Variables 
  bool isMorningSelected = false;
  bool isNoonSelected = false;
  bool isEveSelected = false;
  String selectedMorningReminder = '';
  String selectedNoonReminder = '';
  String selectedEveningReminder = '';

  //Pop Up Two Variables
  bool isBreakfastSelected = false;
  bool isLunchSelected = false;
  bool isDinnerSelected = false;
  String beforeBreakfastReminder = '';
  String afterBreakfastReminder = ''; 
  String beforeLunchReminder = ''; 
  String afterLunchReminder = ''; 
  String beforeDinnerReminder = ''; 
  String afterDinnerReminder = '';
}