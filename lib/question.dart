import 'package:flutter/material.dart';

class Question {
  final String _question;
  final String _answer;

  Question(this._question, this._answer);

  Future<bool?> showQuestion(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    bool? correct;

    return showDialog<bool>(
      context: context,
      builder: (BuildContext buildContext) {
        return StatefulBuilder(
          builder: (BuildContext stateContext, Function(void Function()) setState) {
            return AlertDialog(
              backgroundColor: correct == null ? Colors.white : correct! ? Colors.green : Colors.red,
              icon: Icon(correct == null ? Icons.question_mark : correct! ? Icons.check : Icons.close),
              title: Text(_question),
              content: correct == null ? TextField(
                controller: controller,
              ) : Text(_answer),
              actions: correct == null ? [
                TextButton(
                  onPressed: () => setState(() => correct = controller.text.toLowerCase() == _answer),
                  child: const Text('Submit')
                )
              ] : [
                TextButton(
                  onPressed: () => Navigator.pop(context, correct),
                  child: const Text('Close')
                ),
                if (!correct!)
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Override to Correct')
                  )
              ],
            );
          },
        );
      }
    );
  }
}
