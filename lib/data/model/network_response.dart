class NetworkResponse {
  final bool issucces;
  final int stauscode;
  dynamic responsedata;
  String errormassage;

  NetworkResponse({
    required this.issucces,
    required this.stauscode,
    this.responsedata,
    this.errormassage = 'something wrong',
  });
}
