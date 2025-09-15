// 添加用户对话框组件

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/l10n/generated/l10n.dart';
import '../providers/user_provider.dart';
import '../../common/utils/common_utils.dart';

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
        final localizations = S.of(context);
        CommonUtils.showSnackBar(
          context, 
          localizations.successUserAdded
        );
      } catch (e) {
        // 处理添加失败的情况
        final localizations = S.of(context);
        CommonUtils.showSnackBar(
          context, 
          '${localizations.errorUserAddFailed}: $e'
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
    final localizations = S.of(context);
    
    return AlertDialog(
      title: Text(localizations.pageTitleAddUser),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: localizations.userName),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.validationNameRequired;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: localizations.userEmail),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.validationEmailRequired;
                }
                // 简单的邮箱格式验证
                if (!CommonUtils.isValidEmail(value)) {
                  return localizations.validationEmailInvalid;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: localizations.userPhone),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: Text(localizations.buttonCancel),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitForm,
          child: _isSubmitting
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(localizations.buttonAdd),
        ),
      ],
    );
  }
}