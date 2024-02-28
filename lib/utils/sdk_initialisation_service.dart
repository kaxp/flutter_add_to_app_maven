import 'package:flutter/services.dart';

const _advisorSdkMethodChannelName = 'banksathi_advisor_sdk';
const _sendDataToSDK = 'sendDataToSDK';

enum SDKInitStatus {
  success,
  failed,
}

Future<SdkInitResponse> fetchParamsFromHostApp() async {
  const platform = MethodChannel(_advisorSdkMethodChannelName);
  var result = await platform.invokeMethod(_sendDataToSDK);

  return SdkInitResponse(
    clientSecret: result['clientSecret'] ?? '',
    advisorCode: result['advisorCode'] ?? '',
    agentMobile: result['agentMobile'] ?? '',
    agentEmail: result['agentEmail'] ?? '',
    agentName: result['agentName'] ?? '',
    sdkInitStatus: _getSdkInitStatus(
      result['clientSecret'],
      result['advisorCode'],
    ),
  );
}

/// A model class that convert the param data passed from
/// the Host application into [SdkInitResponse] type.
class SdkInitResponse {
  SdkInitResponse({
    required this.clientSecret,
    required this.advisorCode,
    required this.agentMobile,
    this.agentEmail,
    this.agentName,
    required this.sdkInitStatus,
  });

  final String clientSecret;
  final String advisorCode;
  final String agentMobile;
  final String? agentEmail;
  final String? agentName;

  // sdkInitStatus help us identify if the Native application is sending us
  // all the required data for the working of the Advisor SDK
  // i.e The native application should send clientSecret, mobileNumber and
  // advisorCode.
  final SDKInitStatus sdkInitStatus;
}

/// In case any one of the required params is null then,
/// the sdk should display error to the user.
SDKInitStatus _getSdkInitStatus(
  String clientSecret,
  String advisorCode,
) {
  if (clientSecret.isNotEmpty && advisorCode.isNotEmpty) {
    return SDKInitStatus.success;
  } else {
    return SDKInitStatus.failed;
  }
}
