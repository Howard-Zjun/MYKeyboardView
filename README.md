自定义键盘简化接入方案

问题1：不同地方需要自定义键盘，重复代码太多
解决思路：封装`MYKeyboardAcceptModel`，设置需要使用自定义键盘的`UITextField`、`UITextView`

问题2： 设置了`inputView`后，实体实现的`UITextViewDelegate`方法`textViewDidChange`没有被调用
解决思路：封装继承`UITextViewDelegate`的`MYKeyboardResponseDelegate`委托，通过委托向外部实体传递值变化

问题3：设置了`inputView`后，实体实现的`UITextFieldDelegate`方法`textFieldShouldReturn`没有被调用
解决思路：同上
