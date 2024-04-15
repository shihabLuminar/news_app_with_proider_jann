import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_with_proider_jann/model/new_api_res_model.dart';

class HomeScreenController with ChangeNotifier {
  NewApiResModel? resModel;
  bool isLoading = false;
  Future getData(String searchQuery) async {
    isLoading = true;
    notifyListeners();
    // step1
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchQuery&apiKey=742488509a4f4f23b93e7ac3afc24cad");

    // step2
    var res = await http.get(url);

    //step 3
    if (res.statusCode == 200) {
      //  step 4 - decode
      var decodedData = jsonDecode(res.body);

      //  step 5 //convert to model class
      resModel = NewApiResModel.fromJson(decodedData);
      //step 6 state update
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }
}
