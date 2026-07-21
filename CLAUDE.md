# 펫밀리(Petmily) — Flutter 프로젝트 가이드

펫밀리는 반려동물(강아지/고양이) **AI 헬스케어 앱**이다. 매일 산책·식사 등을 체크해 "펫밀리 레벨"을 올리고, AI 증상 진단을 받고, 성분 분석 기반 맞춤 펫푸드를 쇼핑한다.

이 앱은 기존 React(Vite) 프로토타입을 Flutter로 이식 중이다. **기능·플로우·화면 상세·시드 데이터 등 "이식할 때만 필요한 명세"는 `FLUTTER_PORT_PROMPT.md`에 있다** — 화면을 새로 만들 때 그 문서를 참조하라. 이 `CLAUDE.md`에는 개발 내내 지켜야 할 구조·규칙만 둔다.

---

## 개발 원칙 (항상 준수)

1. **확장성 최우선.** 지금은 목데이터로 동작하지만 곧 백엔드(REST/GraphQL)를 붙인다. 화면 코드가 목데이터를 직접 참조하지 말고 **반드시 Repository를 경유**한다.
2. 원본은 UI만 있던 주먹구구식 프로토타입이었다. **구조는 자유롭게 리팩토링**한다(전역 단일 스토어·파생값 중복 계산 등 안티패턴을 그대로 옮기지 않는다).
3. 각 작업 후 **컴파일·실행 가능** 상태를 유지한다. `flutter analyze` 무경고를 기본으로 한다.

---

## 아키텍처 (계층 분리)

```
Presentation (features/*)   ← 화면 위젯. Riverpod provider만 watch/read
        │
State (state/*)             ← Notifier. 화면 상태·유스케이스
        │
Domain (data/models, data/repositories 인터페이스)
        │
Data (data/repositories/*_impl) ← MockRepository(지금) / ApiRepository(나중)
```

**규칙:**

- 도메인마다 **추상 Repository 인터페이스** + 현재는 `Mock*` 구현. 나중에 `Api*`만 추가하고 provider override로 교체한다.
- Repository 메서드는 전부 `Future<T>` 반환(목이라도 `async`, 필요 시 `await Future.delayed`로 네트워크 흉내). 화면은 **로딩/에러 상태**를 처리한다.
- 모델은 **freezed 불변객체 + `fromJson/toJson`**. JSON 직렬화를 지금부터 넣어 API 응답 매핑에 대비한다.
- 상태는 **도메인별 provider로 분리**한다(전역 단일 스토어 금지).

---

## 디렉토리 구조 (feature-first)

```
lib/
├─ main.dart                       # ProviderScope(child: App())
├─ app.dart                        # MaterialApp.router + Theme
├─ core/
│   ├─ theme/                      # 디자인 토큰 (아래 참조)
│   ├─ router/app_router.dart      # go_router
│   ├─ format/formatters.dart      # 원화/날짜 포맷
│   └─ widgets/                    # 공통: ScaleTap, PrimaryButton, AppBadge,
│                                    AppCard, AppProgressBar, ProductCard, AppBottomNav
├─ data/
│   ├─ models/                     # freezed 모델
│   ├─ repositories/               # 추상 인터페이스 + mock 구현
│   └─ mock/mock_data.dart         # 시드 데이터 (값은 FLUTTER_PORT_PROMPT.md §6)
├─ state/                          # 도메인별 Riverpod Notifier
│   ├─ auth_provider.dart
│   ├─ pet_provider.dart
│   ├─ diagnosis_provider.dart
│   └─ shop_provider.dart
└─ features/
    ├─ splash/  onboarding/  auth/
    ├─ pet_setup/  home/  diagnosis/
    └─ shop/  mypage/
```

파일명은 `snake_case`. `src/pages/Xxx` → `features/xxx/xxx_page.dart`, 공통 컴포넌트 → `core/widgets/`.

---

## 상태관리 (Riverpod)

- 도메인별 `NotifierProvider`로 분리: **Auth / Pet / Diagnosis / Shop**.
- 상태는 불변 객체 + `copyWith`. Dart의 `List`/`Map`은 가변이므로 갱신 시 반드시 `[...list]`/`{...map}`로 **새 인스턴스**를 만들어 리빌드를 트리거한다.
- 파생값(activePet, 오늘자 QuickCheck 등)은 컴포넌트마다 재계산하지 말고 state getter나 별도 provider로 올린다.
- 지금은 메모리 상태지만, 영속화가 필요해지면 Repository 뒤에 `shared_preferences`/서버 동기화를 끼운다(로그인·온보딩·펫 정보가 1순위 후보).

---

## 라우팅 (go_router)

- `context.go('/path')` = 전환, `context.pop()` = 뒤로.
- 쿼리(`?mode=add`)·패스(`:id`) 파라미터 사용.
- 스플래시 초기 분기는 `redirect`로 구현.
- 전 라우트 목록과 화면 플로우는 `FLUTTER_PORT_PROMPT.md` §2 참조.

---

## 디자인 토큰 (core/theme)

- 컬러: primary `#3B82F6`, primary-light `#60A5FA`, primary-deep `#1D4ED8`, 배경 `#F0F7FF`.
- 헤더는 `primary-deep → primary` 세로 그라데이션이 기본 패턴.
- 카드: 흰 배경, 큰 라운드(16~24), 부드러운 그림자.
- 배지 변형: blue/green/red/yellow/purple/gray/orange (연한 배경 + 진한 글자).
- 버튼 변형: primary/secondary/ghost/danger/kakao(`#FEE500`)/google.
- 탭·버튼은 눌림 시 살짝 축소되는 공통 `ScaleTap` 위젯으로 감싼다.
- 원화 표기: `NumberFormat('#,###')` → `"38,000원"`.
- **UI 디자인은 픽셀 단위로 원본과 같을 필요 없다.** Material 관용구 허용. 단 위 브랜드 톤(파란 계열·카드형·둥근모서리·부드러운 그림자)은 유지.

---

## 패키지

```yaml
flutter_riverpod   # 상태관리
go_router          # 라우팅
cached_network_image  # 원격 이미지 (placeholder/errorWidget 필수)
intl               # 숫자/날짜 포맷
flutter_animate    # 애니메이션(선택)
lucide_icons       # 아이콘(Material Icons로 대체 가능)
freezed / json_serializable  # 모델 + JSON 직렬화
```

---

## 백엔드 연동 대비 (미리 심어둘 것)

- `AuthRepository`, `PetRepository`, `DiagnosisRepository`, `ShopRepository` 인터페이스 + `Mock*` 구현. provider는 인터페이스 타입으로 주입.
- 서버가 담당할 로직(진단·상품조회 등)은 mock에서도 비동기로.
- **이미지 업로드(진단 사진), 결제(장바구니), 소셜 로그인(카카오/구글)은 자리만 만들고 `// TODO` 주석**으로 남긴다.
- baseUrl 등 환경설정 config 자리를 마련한다.
