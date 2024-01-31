import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dnd_chat_app/blocs/form_bloc/login_form_bloc.dart';
import 'package:dnd_chat_app/utils/approuter_paths.dart';
import 'package:dnd_chat_app/widgets/loading_dialog.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: Builder(
        builder: (context) {
          final loginFormBloc = context.read<LoginFormBloc>();

          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Center(
              child: FormBlocListener<LoginFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSubmissionFailed: (context, state) {
                  LoadingDialog.hide(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  context.push(AppRouterPaths.home);
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse!)));
                },
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: AutofillGroup(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Image.asset('assets/images/Dnd_logo.png'),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.email,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [
                            AutofillHints.email,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: loginFormBloc.password,
                          suffixButton: SuffixButton.obscureText,
                          autofillHints: const [
                            AutofillHints.password,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: loginFormBloc.submit,
                          child: const Text('Sign in'),
                        ),
                        InkResponse(
                            onTap: () {
                              context.push(AppRouterPaths.sign_up);
                            },
                            child: Container(
                              width: 60,
                              padding: const EdgeInsets.only(top: 2),
                              child: const Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            highlightShape: BoxShape.rectangle,
                            splashFactory: NoSplash.splashFactory),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
