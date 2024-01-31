import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dnd_chat_app/blocs/form_bloc/add_participants_form_bloc.dart';
import 'package:dnd_chat_app/utils/approuter_paths.dart';
import 'package:dnd_chat_app/widgets/app_AppBar.dart';
import 'package:dnd_chat_app/widgets/loading_dialog.dart';

class AddParticipantsScreen extends StatelessWidget {
  const AddParticipantsScreen(
      {required this.id, required this.participants, Key? key})
      : super(key: key);

  final String id;
  final List<String> participants;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddParticipantsFormBloc(id: id, participants: participants),
      child: Builder(
        builder: (context) {
          final formBloc = context.read<AddParticipantsFormBloc>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppAppBar(),
            body: FormBlocListener<AddParticipantsFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSubmissionFailed: (context, state) {
                LoadingDialog.hide(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.successResponse!)));

                context.go(AppRouterPaths.home);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse!)));
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.username,
                      suffixButton: SuffixButton.asyncValidating,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: formBloc.submit,
                      child: const Text('SUBMIT'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
