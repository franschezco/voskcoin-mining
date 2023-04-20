import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? 'Invalid Details' : null,
      controller: controller,
      obscureText: obscureText,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600,fontSize: 16)),
    );
  }
}

class MyPasswordTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<MyPasswordTextField> createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val!.length < 6 ? 'Password too short.' : null,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          suffixIcon: InkWell(onTap: _toggle,
              child: const Icon(Icons.visibility_off)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}



class AmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final String currencySymbol;
  final enabled;
  final onchanged;

  const AmountTextField({
    Key? key,
    required this.controller,
    required this.currencySymbol,
    required this.onchanged,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black, // set the color of the cursor and the label text
        hintColor: Colors.grey[300], // set the color of the hint text
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          prefix: Padding(
            padding: EdgeInsets.only(right: 8),
            child: SizedBox(
              width: 60,
              child: Text(
                currencySymbol,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          hintText: 'Enter amount',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          errorStyle: TextStyle(
            color: Colors.red, // set the color of the error text
          ),
          prefixStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        enabled: enabled,
        onChanged: onchanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Amount is required';
          }
          double? amount = double.tryParse(value);
          if (amount == null || amount <= 0) {
            return 'Please enter a valid amount';
          }
          return null;
        },
      ),
    );
  }
}







class DepositButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;


  const DepositButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    required this.label,
  }) : super(key: key);

  @override
  _DepositButtonState createState() => _DepositButtonState();
}

class _DepositButtonState extends State<DepositButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DepositButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.isLoading ? Colors.grey : Colors.black,
        ),
        child: widget.isLoading
            ? Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rocket_launch_outlined , color: Colors.white),
            SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LoadingButton extends StatefulWidget {
  final String buttonText;
  final Function onPressed;

  LoadingButton({required this.buttonText, required this.onPressed});

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _loading = false;

  void _onPressed() async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(milliseconds: 2000));

    await widget.onPressed();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.transparent),

        onPressed: _loading ? null : _onPressed,
      child : Container(
        height: 105,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
          border: Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.4,
            ),
          ),
        ),
      ),
    );
  }
}
