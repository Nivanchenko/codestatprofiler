Перем ОписаниеКолонок;
Перем Разделитель;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("ОписаниеКолонокТаблицы") _ОписаниеКолонок 
							)
	
	ОписаниеКолонок = _ОписаниеКолонок;
	Разделитель = ";";
КонецПроцедуры

Процедура Записать(Данные, ИмяФайла) Экспорт
	ДанныеИзФормы = ПрочитатьДанныеСФормы(Данные);
	ТекстКСохранению = ТаблицаВЦСВТекст(ДанныеИзФормы);

	ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.UTF8);
	ЗаписьТекста.Записать(ТекстКСохранению);
	ЗаписьТекста.Закрыть();
КонецПроцедуры

Функция ТаблицаВЦСВТекст(Таблица)

	МассивТекстов = Новый Массив();

	МассивТекстов.Добавить(КоллекцияВСтрокуЦСВ(ОписаниеКолонок, "Имя"));

	Для Каждого ТекСтрока Из Таблица Цикл
		МассивТекстов.Добавить(СтрокаТЗВСтрокуЦСВ(ТекСтрока));
	КонецЦикла;
	
	Возврат СтрСоединить(МассивТекстов, Символы.ПС);

КонецФункции

Функция СтрокаТЗВСтрокуЦСВ(СтрокаТЗ)
	Массив = Новый Массив();
	Для Каждого ТекКолонка Из ОписаниеКолонок Цикл
		Массив.Добавить(СтрокаТЗ[ТекКолонка.Имя]);
	КонецЦикла;

	Возврат СтрСоединить(Массив, Разделитель);
КонецФункции

Функция КоллекцияВСтрокуЦСВ(Коллекция, ИмяРеквизита)

	Массив = Новый Массив();
	Для Каждого ЭлементКоллекции из Коллекция Цикл
		Массив.Добавить(ЭлементКоллекции[ИмяРеквизита]);
	КонецЦикла;

	Возврат СтрСоединить(Массив, Разделитель)
	
КонецФункции

Функция ПрочитатьДанныеСФормы(ДанныеФормы)
	Таблица = ТаблицаЗначений();

	Для Счетчик = 0 По ДанныеФормы.Количество - 1 Цикл
		СтрокаДанных = ДанныеФормы.Элемент(Счетчик).Строка;
		СтрокаТЗ = Таблица.Добавить();

		Для НомерКолонки = 0 По ОписаниеКолонок.ВГраница() Цикл
			ТекКолонка = ОписаниеКолонок[НомерКолонки];
			СтрокаТЗ[ТекКолонка.Имя] = СтрокаДанных.Элемент(НомерКолонки).Значение;
		КонецЦикла;
	КонецЦикла;

	Возврат Таблица;
КонецФункции

Функция ТаблицаЗначений()
	ТЗ = Новый ТаблицаЗначений();

	Для Каждого ТекКолонка Из ОписаниеКолонок Цикл
		ТЗ.Колонки.Добавить(ТекКолонка.Имя);
	КонецЦикла;

	Возврат ТЗ;
КонецФункции