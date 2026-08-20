/// 서버가 `isSuccess:false`로 응답했을 때 던지는 예외.
///
/// 공통 응답 봉투의 `code`/`message`를 담는다. 화면은 이걸 잡아 사용자 메시지로 변환한다.
class ApiException implements Exception {
  const ApiException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'ApiException($code, $message)';
}
