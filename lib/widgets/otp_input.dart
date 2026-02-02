import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  // controller already taken???



  const OtpInput({
    super.key,
    this.length = 4,
    required this.onChanged,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Ensure keyboard opens after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Column(
        children: [
          /// Invisible but functional TextField
          SizedBox(
            height: 0,
            width: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {});
              },
            ),
          ),

          /// OTP circles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              final text = index < _controller.text.length
                  ? _controller.text[index]
                  : '';

              final isActive =
                  _controller.text.length == index ||
                      (_controller.text.length == widget.length &&
                          index == widget.length - 1);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _OtpCircle(
                  value: text,
                  isActive: isActive,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _OtpCircle extends StatelessWidget {
  final String value;
  final bool isActive;
  final String hint;

  const _OtpCircle({
    required this.value,
    required this.isActive,
    this.hint = '-',
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = value.isEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: isActive ? Colors.grey.shade300 : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Text(
        isEmpty ? hint : value,
        style: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          color: Colors.grey
        ),
      ),
    );
  }
}
