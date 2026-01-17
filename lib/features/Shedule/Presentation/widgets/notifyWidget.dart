import 'package:flutter/material.dart';


// Функция для вызова уведомления
void showTopNotification(BuildContext context, String message) {
  late OverlayEntry overlayEntry;

  // Создаем вставку в Overlay
  overlayEntry = OverlayEntry(
    builder: (context) => NotifyWidget(
      message: message,
      onDismissed: () {
        // Когда анимация закончилась и виджет уехал наверх — удаляем его из памяти
        overlayEntry.remove();
      },
    ),
  );

  // Вставляем виджет поверх текущего экрана
  Overlay.of(context).insert(overlayEntry);
}

class NotifyWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;

  const NotifyWidget({super.key, required this.message, required this.onDismissed});

  @override
  State<NotifyWidget> createState() => _NotifyWidgetState();
}

class _NotifyWidgetState extends State<NotifyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnim = Tween<Offset>(begin: const Offset(0, -15), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await _controller.forward();

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      await _controller.reverse();
      // Вызываем коллбэк для удаления из Overlay
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter, // Позиционируем сверху
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SlideTransition(
            position: _offsetAnim, // Привязываем анимацию
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColorLight, // Цвет уведомления
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.cardColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.message,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
