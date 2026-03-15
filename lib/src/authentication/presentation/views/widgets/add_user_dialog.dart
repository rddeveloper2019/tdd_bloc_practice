import 'package:bloc_tdd/src/authentication/presentation/blocs/cubit/authentication/authentication_cubit.dart';
import 'package:flutter/material.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key, required this.cubit});
  final AuthenticationCubit cubit; // <-- Принимаем кубит

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Добавить пользователя'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _avatarController,
              decoration: InputDecoration(
                labelText: 'Аватар (URL)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.cubit.createUser(
              createdAt: DateTime.now().toIso8601String(),
              name: _nameController.text,
              avatar: _avatarController.text,
            );

            Navigator.pop(context); // Закрыть диалог
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}
