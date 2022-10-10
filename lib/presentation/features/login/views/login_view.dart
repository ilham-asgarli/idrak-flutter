import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/utils/generics/constants/assets/image_constants.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/utils/generics/notifier/theme_notifier.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/views/base_view.dart';
import '../../../../utils/ui/validators/password_validator.dart';
import '../../../../utils/ui/validators/username_validator.dart';
import '../../../widgets/fractionally_sized_circular_progress_indicator.dart';
import '../notifiers/login_notifier.dart';
import '../view-models/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _loginViewModel;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginViewModel.loginNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginNotifier(),
        ),
        Consumer<LoginNotifier>(builder: (context, notifier, _) {
          return BaseView<LoginViewModel>(
            viewModel: LoginViewModel(),
            onModelReady: (model) {
              _loginViewModel = model;
              _loginViewModel.loginNotifier = notifier;
              model.init(context);

              _usernameController = TextEditingController(
                text: _loginViewModel.getSavedUserName(),
              );
            },
            onPageBuilder: (BuildContext context, LoginViewModel viewModel) =>
                KeyboardVisibilityProvider(
              child: buildBody(context),
            ),
          );
        }),
      ],
    );
  }

  AbsorbPointer buildBody(BuildContext context) {
    return AbsorbPointer(
      absorbing: _loginViewModel.loginNotifier.isLogging,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: context.paddingNormal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible:
                              !KeyboardVisibilityProvider.isKeyboardVisible(
                                  context),
                          child: logoArea(),
                        ),
                        welcomeMessage(),
                        loginInputArea(),
                        Visibility(
                          visible:
                              !KeyboardVisibilityProvider.isKeyboardVisible(
                                  context),
                          child: copyrightArea(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox logoArea() {
    return SizedBox(
      width: context.dynamicWidth(0.3),
      height: context.dynamicHeight(0.3),
      child: Image.asset(context.watch<ThemeNotifier>().isDarkMode
          ? ImageConstants.instance.logoDarkMode
          : ImageConstants.instance.logoLightMode),
    );
  }

  Widget welcomeMessage() {
    return Column(
      children: [
        Text(
          LocaleKeys.welcome.tr(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        widget.verticalSpace(context, 0.01),
        Text(
          LocaleKeys.login.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget loginInputArea() {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          usernameField(),
          widget.verticalSpace(context, 0.02),
          passwordField(),
          widget.verticalSpace(context, 0.03),
          loginButton(),
        ],
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: LocaleKeys.username.tr(),
      ),
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        _loginViewModel.loginModel.username = value;
      },
      validator: (value) {
        return UsernameValidator(value).validate();
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: LocaleKeys.password.tr(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye_rounded),
          onPressed: () {
            _loginViewModel.loginNotifier.changeIsPasswordVisible(
                !_loginViewModel.loginNotifier.isPasswordVisible);
          },
        ),
      ),
      obscureText: !_loginViewModel.loginNotifier.isPasswordVisible,
      enableSuggestions: false,
      autocorrect: false,
      onSaved: (value) {
        _loginViewModel.loginModel.password = value;
      },
      validator: (value) {
        return PasswordValidator(value).validate();
      },
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(
            double.infinity,
            context.dynamicHeight(0.06),
          ),
        ),
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_loginFormKey.currentState!.validate()) {
          _loginViewModel.loginNotifier.changeIsLogging(true);
          _loginFormKey.currentState?.save();

          _loginViewModel.authHelper
              .login(
            context: context,
            mounted: mounted,
            loginModel: _loginViewModel.loginModel,
          )
              .then((value) {
            _loginViewModel.loginNotifier.changeIsLogging(false);
          });
        }
      },
      child: _loginViewModel.loginNotifier.isLogging
          ? const FractionallySizedCircularProgressIndicator(
              factor: 0.5,
            )
          : Text(
              LocaleKeys.login.tr(),
            ),
    );
  }

  Text copyrightArea() {
    return Text(
      "© ${DateTime.now().year.toString()}",
      style: context.textTheme.bodyLarge,
    );
  }
}
