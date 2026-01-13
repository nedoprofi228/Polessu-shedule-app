import 'package:flutter/material.dart';

class SheduleTextField extends StatelessWidget {
  final Function(String value) onChanged;

  const SheduleTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // Container оставляем только для задания размеров (если нужно)
    return SizedBox( 
      height: 35,
      // ВАЖНО: Material должен быть предком для TextField
      child: Material(
        // Переносим стилизацию (цвет и радиус) из BoxDecoration сюда
        color: theme.primaryColorLight,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        // Clip.hardEdge нужен, чтобы обрезать содержимое (например, сплеш-эффекты) по радиусу
        clipBehavior: Clip.hardEdge, 
        
        child: TextField(
          cursorColor: theme.cardColor,
          textAlign: TextAlign.center,
          onChanged: (value) => onChanged(value),
          
          // Выравнивание текста по вертикали (частая проблема в маленьких полях)
          style: theme.textTheme.bodyMedium, 
          textAlignVertical: TextAlignVertical.center,

          decoration: InputDecoration(
            // Используем hintText вместо label для однострочных полей малой высоты,
            // иначе label "уезжает" или обрезается при фокусе
            hintText: "Введите группу / имя преподавателя",
            hintStyle: theme.textTheme.bodySmall,
            
            // Если всё же нужен label c Center, то будьте осторожны с отступами:
            // label: Center(child: Text("Введите группу/имя преподавателя")),
            
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9), 
            // vertical padding помогает центрировать текст в поле высотой 35
            
            border: InputBorder.none,
            isDense: true, // Компактный режим для маленькой высоты
          ),
        ),
      ),
    );
  }
}