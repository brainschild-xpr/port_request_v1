import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const consumerKey = 'AG4FTGaTzmDV5VCc3bhfLD0jy3dJxgoR';
const consumerSecret = '1dsNAZdtDnCGrfRK';
const credentials = '$consumerKey:$consumerSecret';
String authAccess = base64.encode(utf8.encode(credentials));
String basicAuthAccess = 'Basic ' + authAccess;
String accessTokenString;
String bearerAuthToken = 'Bearer ' + accessTokenString;

class AppState with ChangeNotifier {
  AppState() {
    getAccessToken();
  }

  Future getAccessToken() async {
    // var url = 'http://b915aa86.ngrok.io/';
    const accessUrl =
        'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
    var response = await http.get(
      Uri.encodeFull(accessUrl),
      headers: {"Authorization": basicAuthAccess},
    );
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(' ');
      print('Request completed with Status: ${response.statusCode}');
      print(' ');
      // print('${response.body}');
      accessTokenString = responseBody['access_token'];
      print(accessTokenString);
    }
  }

  Future<http.Response> registerUrl() async {
    //Generate AccessToken
    getAccessToken();
    print(accessTokenString);

    const registerUrl =
        'https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl';

    var body = json.encode({
      "ShortCode": "600625",
      "ResponseType": "Complete",
      "ConfirmationURL": "http://3a2cbf70.ngrok.io/confirmation",
      "ValidationURL": "http://3a2cbf70.ngrok.io/confirmation"
    });

    Map<String, String> headers = {
      'Authorization': bearerAuthToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    http.Response responseReg = await http.post(
      Uri.encodeFull(registerUrl),
      headers: headers,
      body: body,
    );
    // print(responseReg.body);
    var registerRespBody = jsonDecode(responseReg.body);
    print(
        '\nRegisterUrl call finished ${registerRespBody['ResponseDescription']}fully');
    // print(registerRespBody['ConversationID']);
    // print(registerRespBody['OriginatorCoversationID']);

    return null;
  }

  Future<http.Response> simulate() async {
    const simulateUrl = 'https://sandbox.safaricom.co.ke/mpesa/c2b/v1/simulate';

    var body = json.encode({
      'ShortCode': '600565',
      'CommandID': 'CustomerPayBillOnline',
      'Amount': '100',
      'Msisdn': '254708374149',
      'BillRefNumber': 'testapi113'
    });

    Map<String, String> headers = {
      'Authorization': bearerAuthToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    http.Response responseReg = await http.post(
      Uri.encodeFull(simulateUrl),
      headers: headers,
      body: body,
    );

    var simulateRespBody = jsonDecode(responseReg.body);
    // print(simulateRespBody);
    print('\nSimulateUrl : ${simulateRespBody['ResponseDescription']}\n');
    print('ConversationID: ${simulateRespBody['ConversationID']}');
    print(
        'Originator CoversationID: ${simulateRespBody['OriginatorCoversationID']}');

    return null;
  }

  Future<http.Response> balance() async {
    const balanceUrl =
        'https://sandbox.safaricom.co.ke/mpesa/accountbalance/v1/query';

    var body = json.encode({
      'Initiator': 'testapi113',
      'SecurityCredential':
          'cgkxyaHhOCGWHBaMdy8/NJc7oytOVH3OZEdP8jhgojA3Qs8saV52EnAHoV0V5yRlo5GYJtueordaWD6N5CzZePYMMVd8+vcoqlGXB0/K0XiRD/HeJUlcHto+/wzbPGf4eJVRLgrSsAHlTAxVUmMo1FoxcBl+u1bD82nKk5uD7mPtYQUXs85m/oHZENBTnhAOsOkuSgIWE5jBLoFtdA+gDeqGVPh/4MOgR8OAmcp24ma+RXIZWQ9mWb/mJr9AdB+6ld2kCwKFmaFOxvmSNZ1cGGVc+q+7KYo7RkzuTuQg/C/FMzBczvcj80E1++93JCTikUxlbJ+cZucZK1AZKcpBzw==',
      'CommandID': 'AccountBalance',
      'PartyA': '600565',
      'IdentifierType': '4',
      'Remarks': ' Greate Service',
      'QueueTimeOutURL': 'http://3a2cbf70.ngrok.io/timeout',
      'ResultURL': 'http://3a2cbf70.ngrok.io/result'
    });

    Map<String, String> headers = {
      'Authorization': bearerAuthToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    http.Response responseReg = await http.post(
      Uri.encodeFull(balanceUrl),
      headers: headers,
      body: body,
    );

    var balanceRespBody = jsonDecode(responseReg.body);
    print(balanceRespBody);
    print('\nbalanceUrl : ${balanceRespBody['ResponseDescription']}\n');
    print('Exited with response code : ${balanceRespBody['ResponseCode']} ');
    print('ConversationID: ${balanceRespBody['ConversationID']}');
    print(
        'Originator CoversationID: ${balanceRespBody['OriginatorConversationID']}');

    return null;
  }

  Future<http.Response> stkPush() async {
    // registerUrl();
    const stkPushUrl =
        'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';

    var year = new DateTime.now().year;
    print(year);

    var convMonth;
    int month = new DateTime.now().month;
    if (month <= 9) {
      convMonth = month.toString();
      convMonth = '0' + convMonth;
    } else {
      convMonth = month;
    }
    print(convMonth);

    var convDate;
    var date = new DateTime.now().day;
    if (date <= 9) {
      convDate = date.toString();
      convDate = '0' + convDate;
    } else {
      convDate = date;
    }
    print(convDate);

    var convHour;
    var hour = new DateTime.now().hour;
    if (hour <= 9) {
      convHour = hour.toString();
      convHour = '0' + convHour;
    } else {
      convHour = hour;
    }
    print(convHour);

    var convMinute;
    var minute = new DateTime.now().minute;
    if (minute <= 9) {
      convMinute = minute.toString();
      convMinute = '0' + convMinute;
    } else {
      convMinute = minute;
    }
    print(convMinute);

    var convSecond;
    var second = new DateTime.now().second;
    if (second <= 9) {
      convSecond = second.toString();
      convSecond = '0' + convSecond;
    } else {
      convSecond = second;
    }
    print(convSecond);

    String timestamp = year.toString() +
        convMonth.toString() +
        convDate.toString() +
        convHour.toString() +
        convMinute.toString() +
        convSecond.toString();
    print(timestamp);

    String passwordEncode = '174379' +
        'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919' +
        timestamp;
    print(passwordEncode);
    String password = base64.encode(utf8.encode(passwordEncode));
    print(password);
    // DateTime startDate = await NTP.now();
    // print('NTP DateTime: ${startDate}');

    var body = json.encode({
      'BusinessShortCode': '174379',
      'Password': password,
      'Timestamp': timestamp,
      'TransactionType': 'CustomerPayBillOnline',
      'Amount': '1',
      'PartyA': '254708374149',
      'PartyB': '174379',
      'PhoneNumber': '254716806025',
      'CallBackURL': 'http://3a2cbf70.ngrok.io/stk_callback',
      'AccountReference': 'BemcaOnline',
      'TransactionDesc': 'Total Payment'
    });

    Map<String, String> headers = {
      'Authorization': bearerAuthToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    http.Response responseReg = await http.post(
      Uri.encodeFull(stkPushUrl),
      headers: headers,
      body: body,
    );

    var stkPushRespBody = jsonDecode(responseReg.body);
    print(stkPushRespBody);
    print(
        '\nResponseDescription : ${stkPushRespBody['ResponseDescription']}\n');
    print('\nExited with response code : ${stkPushRespBody['ResponseCode']}\n');
    print('\nMerchantRequestID: ${stkPushRespBody['MerchantRequestID']}\n');
    print('\nCheckoutRequestID: ${stkPushRespBody['CheckoutRequestID']}\n');
    print('\nCustomerMessage: ${stkPushRespBody['CustomerMessage']}\n');

    return null;
  }

  Future<String> photoUrl() async {
    final response = await http.get(
      Uri.encodeFull('https://jsonplaceholder.typicode.com/photos'),
    );
    List data = json.decode(response.body);
    print(response.body);
    // print(data[3]);
    print(data[3]['url']);
    var photoUrlString = data[4]['url'];

    return photoUrlString;
  }

  // Future that() async {
  //   var data = {'title': 'My first post'};
  //   const registerUrl =
  //       'https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl';
  //   HttpRequest.request(registerUrl,
  //       method: 'POST',
  //       sendData: json.encode(data),
  //       requestHeaders: {
  //         'Content-Type': 'application/json; charset=UFT-8',
  //       }).then((resp) {
  //     print(resp.responseUrl);
  //     print(resp.responseText);
  //   });
  // }
}
