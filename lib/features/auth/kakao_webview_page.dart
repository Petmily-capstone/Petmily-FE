import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/config/app_config.dart';
import '../../core/theme/theme.dart';

/// 카카오 인가 코드를 받아오는 WebView.
///
/// authorize 화면을 띄우고, [AppConfig.kakaoRedirectUri]로 리다이렉트되는 순간
/// 네비게이션을 가로채 `code`를 추출한 뒤 `Navigator.pop(code)`로 반환한다. redirect_uri는
/// 실제로 로드하지 않으므로(로컬 주소여도) 접속 성공 여부와 무관하게 동작한다.
///
/// 반환값: 성공 시 인가 코드(String), 사용자가 취소하면 null.
class KakaoAuthWebView extends StatefulWidget {
  const KakaoAuthWebView({super.key});

  @override
  State<KakaoAuthWebView> createState() => _KakaoAuthWebViewState();
}

class _KakaoAuthWebViewState extends State<KakaoAuthWebView> {
  final _config = AppConfig.dev;
  late final WebViewController _controller;
  bool _loading = true;
  bool _completed = false; // 중복 pop 방지

  Uri get _authorizeUri => Uri.https(
        'kauth.kakao.com',
        '/oauth/authorize',
        {
          'client_id': _config.kakaoRestApiKey,
          'redirect_uri': _config.kakaoRedirectUri,
          'response_type': 'code',
        },
      );

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith(_config.kakaoRedirectUri)) {
              _complete(Uri.parse(request.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadRequest(_authorizeUri);
  }

  /// redirect_uri로 이동 시 code(없으면 null)를 뽑아 화면을 닫는다.
  void _complete(Uri url) {
    if (_completed) return;
    _completed = true;
    final code = url.queryParameters['code'];
    if (mounted) Navigator.of(context).pop(code); // code 없으면 null → 실패 처리
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카카오 로그인'),
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
