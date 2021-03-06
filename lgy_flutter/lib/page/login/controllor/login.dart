import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/logInModel.dart';
import '../../../util/feature/SimpleStorage.dart';
import '../../../constant//StorageKey.dart';
import '../../../util/viewWidget/Toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogIn extends StatefulWidget {
  _LogInState createState() => new _LogInState();
}

class _LogInState extends State {
  String _username;
  String _password;
  bool _isLoading = false;

  void _checkUsername(value) {
    _username = value;
  }

  void _checkPassword(value) {
    _password = value;
  }

  void _showToast(msg) {
    Toast.showToast(msg);
  }

  void _login() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var result = await LoginModel.login(_username, _password);
      Map resultMap = json.decode(result);
      if (resultMap["ok"] == false) {
        _showToast("登陆失败，请验证账号密码是否正确");
        return;
      }
      // 获取accessToken
      // 这里拿数据需要一个专门处理拿数据的model
      var accessToken = resultMap['result']['access_token'];
      // 存入本地缓存
      await Storage.saveString(StorageKey.accessToken, accessToken);
      // 跳转到写好的路由
      Navigator.pushNamed(context, "home");
    } catch (error) {
      _showToast("$error");
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _checkTextInput() {
    if (_username.isEmpty || _password.isEmpty) {
      print('有空');
      return;
    }
    _login();
  }

  @override
  Widget build(BuildContext context) {
    // 一定要在第一次build context的时候初始化
    Widget titleSection = Container(
      padding: EdgeInsets.all(36.w),
      margin: EdgeInsets.only(bottom: 36.w),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '欢迎登陆来玩管理界面',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Image.asset(
            'images/login/img_password.png',
            width: 100.w,
            height: 100.h,
          ))
        ],
      ),
    );

    Widget userNameSection = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请输入用户名'),
          TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              onChanged: (value) => _checkUsername(value)),
        ],
      ),
    );

    Widget passwordSection = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请输入密码'),
          TextField(
              obscureText: true,
              autofocus: true,
              onChanged: (value) => _checkPassword(value)),
        ],
      ),
    );

    Widget buttonSection = GestureDetector(
        onTap: _checkTextInput,
        child: Container(
          margin: EdgeInsets.only(top: 60.h),
          child: Image.asset(
            'images/login/btn_sign_in.png',
            width: 500.w,
            height: 80.h,
          ),
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: ModalProgressHUD(
          child: Container(
            width: 1.wp,
            height: 1000.h,
            child: Column(
              children: [
                titleSection,
                userNameSection,
                passwordSection,
                buttonSection,
              ],
            ),
          ),
          inAsyncCall: _isLoading,
        ));
  }
}
