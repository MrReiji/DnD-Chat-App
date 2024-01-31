import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:dnd_chat_app/blocs/form_bloc/chat_form_bloc.dart';
import 'package:dnd_chat_app/widgets/loading_dialog.dart';

class NewMessage extends StatelessWidget {
  const NewMessage({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatFormBloc(id),
      child: Builder(
        builder: (context) {
          final chatFormBloc = context.read<ChatFormBloc>();

          return FormBlocListener<ChatFormBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onSubmissionFailed: (context, state) {
              LoadingDialog.hide(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);

              // context.push(AppRouterPaths.home);
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failureResponse!)));
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: AutofillGroup(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldBlocBuilder(
                        padding: EdgeInsets.all(10),
                        textFieldBloc: chatFormBloc.text,
                        keyboardType: TextInputType.text,
                        autofillHints: const [
                          //AutofillHints.language,
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Send a message ...',
                        ),
                      ),
                    ),
                    IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      icon: const Icon(
                        Icons.send,
                      ),
                      onPressed: () {
                        chatFormBloc.submit();
                      },
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
