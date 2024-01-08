import 'dart:async';
import 'dart:convert';

import 'package:app/bloc/token/token_bloc.dart';
import 'package:app/services/state/state_handler_bloc.dart';
import 'package:app/utils/my_dot_env_getter.dart';
import 'package:app/utils/my_toast.dart';
import 'package:app/widgets/my_error_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class API {
  String baseUrl = kIsWeb
      ? getDotEnvValue('WEB_API_BASE_URL')
      : getDotEnvValue('API_BASE_URL');

  Future<dynamic> getData({
    required String endpoint,
    required BuildContext context,
    String? googleMapBaseURL,
  }) async {
    try {
      String? token = BlocProvider.of<TokenBloc>(context).state.token;
      final response = await http.get(
        Uri.parse((googleMapBaseURL ?? baseUrl) + endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } on TimeoutException {
      /// create a bloc to show timeout card in UI
    }
  }

  Future<dynamic> postData({
    required context,
    required dynamic model,
    required String endpoint,
    required StateHandlerBloc bloc,
    required Function(dynamic response) func,
  }) async {
    String? token = BlocProvider.of<TokenBloc>(context).state.token;
    bloc.storeData(data: 1);
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl + endpoint),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: model == null ? null : jsonEncode(model.toJson()),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        bloc.storeData(data: 0);
        dynamicError(context, response);
      } else {
        bloc.storeData(data: 0);
        func(response.body);
        var test = jsonDecode(response.body);
        myToast.toast(msg: test['message'].toString(), context: context);
        return response;
      }
    } on TimeoutException {
      errorBottomSheet(
        context: context,
        data: 'Request Timeout.',
        statusCode: 408,
      );
      bloc.storeData(data: 0);
      return 408;
    }
  }

  Future<dynamic> deleteData({
    required context,
    required dynamic model,
    required String endpoint,
    required StateHandlerBloc bloc,
    required Function(dynamic response) func,
  }) async {
    String? token = BlocProvider.of<TokenBloc>(context).state.token;
    bloc.storeData(data: 1);
    try {
      final response = await http
          .delete(
            Uri.parse(baseUrl + endpoint),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: model == null ? null : jsonEncode(model.toJson()),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        bloc.storeData(data: 0);
        dynamicError(context, response);
      } else {
        bloc.storeData(data: 0);
        func(response.body);
        var test = jsonDecode(response.body);
        myToast.toast(msg: test['message'].toString(), context: context);
        return response;
      }
    } on TimeoutException {
      errorBottomSheet(
        context: context,
        data: 'Request Timeout.',
        statusCode: 408,
      );
      bloc.storeData(data: 0);
      return 408;
    }
  }

  dynamic dynamicError(context, http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 400:
        addErrorEvent(context, response);
        return response;

      case 401:
        addErrorEvent(context, response);
        return response;

      case 403:
        addErrorEvent(context, response);
        return response;

      case 408:
        addErrorEvent(context, response);
        return response;

      case 404:
        errorBottomSheet(
          context: context,
          data: 'Page Not Found',
          statusCode: 404,
        );
        return response;

      case 405:
        errorBottomSheet(
          context: context,
          data: 'Invalid http request method.',
          statusCode: 405,
        );
        return response;

      case 409:
        addErrorEvent(context, response);
        return response;

      case 422:
        addErrorEvent(context, response);
        return response;

      default:
        errorBottomSheet(
          context: context,
          data: 'Server is busy ${response.body}',
          statusCode: 500,
        );
        return response;
    }
  }

  addErrorEvent(context, http.Response response) {
    var test = jsonDecode(response.body);
    errorBottomSheet(
      context: context,
      data: test['message'].toString(),
      statusCode: response.statusCode,
    );
  }
}

API api = API();
