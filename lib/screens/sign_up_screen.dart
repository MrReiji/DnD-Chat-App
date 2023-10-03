import 'package:dnd_chat_app/blocs/form_bloc/login_form/login_form_bloc.dart';
import 'package:dnd_chat_app/utils/approuter_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/cubits/image_picker/image_picker_cubit.dart';
import '../blocs/form_bloc/signUp_form_bloc/signUp_form_bloc.dart';
import '../models/image_picker.dart';
import '../widgets/loading_dialog.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpFormBloc(),
      child: Builder(
        builder: (context) {
          final signUpFormBloc = context.read<SignUpFormBloc>();
          context.read<ImagePickerCubit>().clearImage();

          return Scaffold(
            appBar: AppBar(),
            resizeToAvoidBottomInset: false,
            body: Center(
              child: FormBlocListener<SignUpFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSubmissionFailed: (context, state) {
                  LoadingDialog.hide(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  context.go(AppRouterPaths.home);
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImagePickerWidget(
                          onPickImage: (pickedImage) {
                            signUpFormBloc.selectedImage = pickedImage;
                          },
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: signUpFormBloc.username,
                          keyboardType: TextInputType.name,
                          autofillHints: const [
                            AutofillHints.username,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: signUpFormBloc.email,
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
                          textFieldBloc: signUpFormBloc.password,
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
                          onPressed: signUpFormBloc.submit,
                          child: const Text('Sign up'),
                        ),
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
