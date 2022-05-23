class APIErrorResponse {
  int code;
  String title;
  String msg;

  APIErrorResponse({
    this.code = -1,
    this.title = '',
    this.msg = '',
  });
  @override
  String toString() {
    return '($code) $msg';
  }
}
