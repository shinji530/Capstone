import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:capstone/login_platform.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });

    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _loginPlatform != LoginPlatform.none
              ? _logoutButton()
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loginButton(
                'kakao_logo',
                signInWithKakao,
              )
            ],
          )),
    );
  }

  Widget _loginButton(String path, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(top: 200.0),
      //elevation: 0.0,
      //shape: const CircleBorder(),
      //clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/planet_icon.png'),
            width: 170.0,
            height: 190.0,),
          Text(
            '그린패스',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: 50,),
          Ink.image(
            image: AssetImage('assets/kakao_login.png'),
            width: 200,
            height: 100,
            child: InkWell(
              // borderRadius: const BorderRadius.all(
              //   Radius.circular(35.0),
              // ),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff0165E1),
        ),
      ),
      child: const Text('로그아웃'),
    );
  }
}
// }
// // 카카오 로그인 구현 예제
//
// // 카카오톡 설치 여부 확인
// // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
// if (await isKakaoTalkInstalled()) {
// try {
// await UserApi.instance.loginWithKakaoTalk();
// print('카카오톡으로 로그인 성공');
// } catch (error) {
// print('카카오톡으로 로그인 실패 $error');
//
// // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
// // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
// if (error is PlatformException && error.code == 'CANCELED') {
// return;
// }
// // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
// try {
// await UserApi.instance.loginWithKakaoAccount();
// print('카카오계정으로 로그인 성공');
// } catch (error) {
// print('카카오계정으로 로그인 실패 $error');
// }
// }
// } else {
// try {
// await UserApi.instance.loginWithKakaoAccount();
// print('카카오계정으로 로그인 성공');
// } catch (error) {
// print('카카오계정으로 로그인 실패 $error');
// }
// }
// try {
// User user = await UserApi.instance.me();
// print('사용자 정보 요청 성공'
// '\n회원번호: ${user.id}'
// '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
// '\n이메일: ${user.kakaoAccount?.email}');
// } catch (error) {
// print('사용자 정보 요청 실패 $error');
// }
// User user;
//
// try {
// user = await UserApi.instance.me();
// } catch (error) {
// print('사용자 정보 요청 실패 $error');
// return;
// }
//
// List<String> scopes = [];
//
// if (user.kakaoAccount?.emailNeedsAgreement == true) {
// scopes.add('account_email');
// }
// if (user.kakaoAccount?.birthdayNeedsAgreement == true) {
// scopes.add("birthday");
// }
// if (user.kakaoAccount?.birthyearNeedsAgreement == true) {
// scopes.add("birthyear");
// }
// if (user.kakaoAccount?.ciNeedsAgreement == true) {
// scopes.add("account_ci");
// }
// if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) {
// scopes.add("phone_number");
// }
// if (user.kakaoAccount?.profileNeedsAgreement == true) {
// scopes.add("profile");
// }
// if (user.kakaoAccount?.ageRangeNeedsAgreement == true) {
// scopes.add("age_range");
// }
//
// if (scopes.length > 0) {
// print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');
//
// // OpenID Connect 사용 시
// // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
// // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
// // scopes.add("openid")
//
// //scope 목록을 전달하여 카카오 로그인 요청
// OAuthToken token;
// try {
// token = await UserApi.instance.loginWithNewScopes(scopes);
// print('현재 사용자가 동의한 동의 항목: ${token.scopes}');
// } catch (error) {
// print('추가 동의 요청 실패 $error');
// return;
// }
//
// // 사용자 정보 재요청
// try {
// User user = await UserApi.instance.me();
// print('사용자 정보 요청 성공'
// '\n회원번호: ${user.id}'
// '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
// '\n이메일: ${user.kakaoAccount?.email}');
// } catch (error) {
// print('사용자 정보 요청 실패 $error');
// }
// }