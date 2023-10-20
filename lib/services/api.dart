import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quizapp/constants/api_const.dart';

import '../models/chat_model.dart';
import '../models/models.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      if (response.statusCode == 200) {
        Map jsonResponse = jsonDecode(response.body);

        if (jsonResponse['error'] != null) {
          throw HttpException(jsonResponse['error']["message"]);
        }

        List temp = [];
        for (var value in jsonResponse["data"]) {
          temp.add(value);
        }

        return ModelsModel.modelsFromSnapshot(temp);
      } else {
        log("HTTP Status Code: ${response.statusCode}");
        throw HttpException(
            "Failed to fetch models. Status code: ${response.statusCode}");
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessageGPT(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      if (response.statusCode == 200) {
        Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

        if (jsonResponse['error'] != null) {
          throw HttpException(jsonResponse['error']["message"]);
        }

        List<ChatModel> chatList = [];
        if (jsonResponse["choices"].length > 0) {
          chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
              message: jsonResponse["choices"][index]["message"]["content"],
              chatIndex: 1,
            ),
          );
        }
        return chatList;
      } else {
        log("HTTP Status Code: ${response.statusCode}");
        throw HttpException(
            "Failed to send message. Status code: ${response.statusCode}");
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // You can similarly add status code handling to other API request methods.

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 300,
          },
        ),
      );

      if (response.statusCode == 200) {
        Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

        if (jsonResponse['error'] != null) {
          throw HttpException(jsonResponse['error']["message"]);
        }

        List<ChatModel> chatList = [];
        if (jsonResponse["choices"].length > 0) {
          chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
              message: jsonResponse["choices"][index]["text"],
              chatIndex: 1,
            ),
          );
        }
        return chatList;
      } else {
        log("HTTP Status Code: ${response.statusCode}");
        throw HttpException(
            "Failed to send message. Status code: ${response.statusCode}");
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
