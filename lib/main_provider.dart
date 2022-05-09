import 'package:flutter/widgets.dart';

class MainProvider extends ChangeNotifier{
  void updateTaskList(){
    notifyListeners();
  }
}