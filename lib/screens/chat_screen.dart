import 'package:dnd_chat_app/widgets/app_AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../blocs/form_bloc/chat_form_bloc.dart';
import '../widgets/chat_messages.dart';
import '../widgets/loading_dialog.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatFormBloc(),
      child: Builder(
        builder: (context) {
          final chatFormBloc = context.read<ChatFormBloc>();

          return Scaffold(
            appBar: App_AppBar(),
            resizeToAvoidBottomInset: true,
            body: FormBlocListener<ChatFormBloc, String, String>(
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
              child: Column(
                children: [
                  Expanded(
                    child: ChatMessages(),
                  ),
                  SingleChildScrollView(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
