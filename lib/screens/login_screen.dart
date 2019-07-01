import 'package:flutter/material.dart';
import 'package:simplefire/helpers/validators.dart';
import 'package:simplefire/presenters/login_presenter.dart';
import 'package:validate/validate.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPresenter presenter;
  double shortestSize = 0.0;

  @override
  void initState() {
    super.initState();

    presenter = new LoginPresenter(this);
    presenter.isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // TODO: Remove here after development
        presenter.currentStaff.email = "aykut@apoblo.com";
        presenter.currentStaff.password = "12345678";
        _emailController.text = presenter.currentStaff.email;
        _passwordController.text = presenter.currentStaff.password;
      }
    });
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var headerFont = 29.0;
    var logoSize = 1.0;
    var currentOrientation = MediaQuery.of(context).orientation;
    shortestSize = MediaQuery.of(context).size.shortestSide;

    if (Orientation.portrait == currentOrientation && shortestSize > 600) {
      logoSize = 1.3;
      headerFont = 69.0;
    } else if (shortestSize > 600) {
      logoSize = 2.4;
      headerFont = 69.0;
    } else {
      logoSize = 1.0;
      headerFont = 29.0;
    }
    return presenter.applicationScreen.widgetWithHud(

      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child:

         Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                  Container(
                    child: Image.network(
                        'http://www.daimontech.com/assets/img/logo_sm.png',
                        width: MediaQuery.of(context).size.width / logoSize),
                    decoration: BoxDecoration(color: Colors.black),
                  ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08),
                  Text(
                    'Giriş',
                    style: TextStyle(fontSize: headerFont),
                  ),
              SizedBox(height: 16.0),
              TextFormField(
                autocorrect: false,
                controller: _emailController,
                onSaved: (val) {
                  presenter.currentStaff.email = val;
                },
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    CustomValidators.validate(val, Validate.isEmail),
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                autocorrect: false,
                controller: _passwordController,
                onSaved: (val) {
                  presenter.currentStaff.password = val;
                },
                validator: (val) =>
                    CustomValidators.validate(val, Validate.isPassword),
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Kayıt ol'),
                    onPressed: () {
                      presenter.signupButtonClicked();
                    },
                  ),
                  RaisedButton(
                    child: Text('Giriş Yap'),
                    onPressed: () {
                      presenter.loginButtonClicked();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        ),],
      ),
      footBar: false,
      appBar: false,
    );
  }
}
