// 添加用户对话框组件

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnDemo2/src/common/l10n/app_localizations.dart';
import '../../providers/user_provider.dart';
import '../../../common/utils/common_utils.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({Key? key}) : super(key: key);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // 提交表单，添加新用户
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // 通过Provider添加用户
        await Provider.of<UserProvider>(context, listen: false)
            .addUser(
              _nameController.text,
              _emailController.text,
              _phoneController.text.isNotEmpty ? _phoneController.text : null,
            );
        
        // 添加成功后关闭对话框
        Navigator.of(context).pop();
        
        // 显示成功提示
        final localizations = AppLocalizations.of(context);
        CommonUtils.showSnackbar(
          context, 
          localizations?.successUserAdded ?? 'User added successfully'
        );
      } catch (e) {
        // 处理添加失败的情况
        final localizations = AppLocalizations.of(context);
        CommonUtils.showSnackbar(
          context, 
          '${localizations?.errorUserAddFailed ?? 'Failed to add user'}: $e'
        );
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return AlertDialog(
      title: Text(localizations?.pageTitleAddUser ?? 'Add User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: localizations?.userName ?? 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations?.validationNameRequired ?? 'Please enter name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: localizations?.userEmail ?? 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations?.validationEmailRequired ?? 'Please enter email';
                }
                // 简单的邮箱格式验证
                if (!CommonUtils.isValidEmail(value)) {
                  return localizations?.validationEmailInvalid ?? 'Please enter a valid email address';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: localizations?.userPhone ?? 'Phone (optional)'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations?.buttonCancel ?? 'Cancel'),
          enabled: !_isSubmitting,
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitForm,
          child: _isSubmitting
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(localizations?.buttonAdd ?? 'Add'),
        ),
      ],
    );
  }
}