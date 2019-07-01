import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:simplefire/helpers/lists.dart';
import 'package:validate/validate.dart';
import 'package:simplefire/presenters/signup_presenter.dart';
import 'package:simplefire/screens/widgets/rounded_box.dart';
import 'package:simplefire/helpers/validators.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => new _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new SignupPresenter(this);
    presenter.prepareScreen();
    businessTypeItems = new List();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final phoneController = new MaskedTextController(mask: '(000) 000 0000');

  //final phoneExtController = new MaskedTextController(mask: '000000');
  //final faxController = new MaskedTextController(mask: '(000) 000 0000');

  List<DropdownMenuItem> businessTypeItems = new List();

  @override
  Widget build(BuildContext context) {
    return presenter.applicationScreen.widgetWithHud(
      Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  Image.network(
                      'http://www.daimontech.com/assets/img/logo_sm.png',
                      width: 60),
                  SizedBox(height: 10.0),
                  Text(
                    'COTTONHILL',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  Text(
                    'Kayıt Ol',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new RoundedBox(
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            // controller: _passwordController,
                            validator: (val) => CustomValidators.validate(
                                val, Validate.notBlank),
                            onSaved: (val) {
                              presenter.company.companyStaffs.first.firstName =
                                  val;
                            },
                            decoration: InputDecoration(
                              labelText: 'İsim',
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: TextFormField(
                            // controller: _passwordController,
                            validator: (val) => CustomValidators.validate(
                                val, Validate.notBlank),
                            onSaved: (val) {
                              presenter.company.companyStaffs.first.lastName =
                                  val;
                            },
                            decoration: InputDecoration(
                              labelText: 'Soyisim',
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    TextFormField(
                      // controller: _passwordController,
                      validator: (val) =>
                          CustomValidators.validate(val, Validate.notBlank),
                      onSaved: (val) {
                        presenter.company.name = val;
                      },
                      decoration: InputDecoration(
                        labelText: 'Şirket adı',
                      ),
                    ),
                    TextFormField(
                      // controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          CustomValidators.validate(val, Validate.isEmail),
                      onSaved: (val) {
                        presenter.company.companyStaffs.first.email = val;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      // controller: _passwordController,
                      validator: (val) {
                        if (val.length < 5) {
                          return CustomValidators.validate(
                              val, Validate.isPassword);
                        }
                      },
                      onSaved: (val) {
                        presenter.company.companyStaffs.first.password = val;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                      ),
                    ),
                    TextFormField(
                      // controller: _passwordController,
                      obscureText: true,
                      validator: (val) {
                        if (val.length < 5) {
                          return "Not match";
                        }
                      },
                      onSaved: (val) {
                        presenter.company.companyStaffs.first
                            .passwordConfirmation = val;
                      },
                      decoration: InputDecoration(
                        labelText: 'Şifre onay',
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (val) =>
                          CustomValidators.validate(val, Validate.notBlank),
                      onSaved: (val) {
                        presenter.company.phone = val;
                      },
                      decoration: InputDecoration(
                        labelText: 'Telefon numarası',
                      ),
                    ),
                    FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Şehir',
                            contentPadding: EdgeInsetsDirectional.only(
                              top: 12.0,
                              bottom: 7.0,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 24.0,
                              isExpanded: true,
                              value: presenter.addressState,
                              isDense: true,
                              items: states_list_dropdown,
                              onChanged: (value) => addressStateChanged(value),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                title: "Customer Information",
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Giriş Yap'),
                    onPressed: () {
                      presenter.loginButtonClicked();
                    },
                  ),
                  RaisedButton(
                    child: Text('Signup'),
                    onPressed: () {
                      presenter.signupButtonClicked();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      footBar: false,
      appBar: false,
    );
  }

  addressStateChanged(value) {
    setState(() {
      presenter.addressState = value;
      presenter.company.address.state = value;
    });
  }
}
