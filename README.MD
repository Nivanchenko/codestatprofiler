## codestatprofiler

Утилита с графическим интерфейсом для визуализации времени и количества вызовов исполняемого кода ```oscript```

### Установка

```bash
opm intstall codestatprofiler
```

### Использование

Запускаем любой ваш скрипт с замером

```bash
oscript -codestat=stat.json МойСуперНагруженный.os
```

После выполнения будет сгенерирован файл со статистикой.

Запуск из консоли

```bash 
codestatprofiler
```

В графичеком интерфейсе Файл > Открыть.

### Ограничения и особенности

Стоит помнить что вызов ```-codestat``` сам по себе дает нагрузку, и общее время отличается от запуска без этого ключа.

На текущий момент графическая библиотека поддерживает только платформу Windows.
