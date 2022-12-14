&Пластилин Перем КешФайлов Экспорт;

Перем ОписаниеКолонок;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("ОписаниеКолонокТаблицы") _ОписаниеКолонок 
							)

ОписаниеКолонок = _ОписаниеКолонок;

КонецПроцедуры

Функция ПрочитатьФайлВТаблицу(ПутьКФайлу) Экспорт

	ДанныеСтатистики = РаспарситьФайл(ПутьКФайлу);
	Возврат ТаблицаПоДаннымСтатистики(ДанныеСтатистики);

КонецФункции

Функция ТаблицаПоДаннымСтатистики(ДанныеСтатистики)

	ТаблицаСтатистики = ОписаниеТаблицы();	
	КешФайлов.Очистить();

	Для Каждого ТекФайл из ДанныеСтатистики Цикл
		ИмяФайла = ТекФайл.Ключ;
		Для каждого Метод Из ТекФайл.Значение Цикл
			ИмяМетода = Метод.Ключ;
			Если СтрНачинаетсяС(ИмяМетода, "#") Тогда
				Продолжить;
			КонецЕсли;
			Для каждого СтрокаМетода Из Метод.Значение Цикл
				НомерСтроки = СтрокаМетода.Ключ;
				КоличествоВызовов = СтрокаМетода.Значение["count"];
				ВремяВыполнения = СтрокаМетода.Значение["time"];
				НоваяСтрока = ТаблицаСтатистики.Добавить();
				НоваяСтрока.Файл = ИмяФайла;
				НоваяСтрока.Метод = ИмяМетода;
				НоваяСтрока.НомерСтроки = НомерСтроки;
				НоваяСтрока.КоличествоВызовов = КоличествоВызовов;
				НоваяСтрока.ВремяВыполнения = ВремяВыполнения;
				НоваяСтрока.СодержаниеСтроки = КешФайлов.ПолучитьСтрокуИзФайла(ИмяФайла, НомерСтроки);
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;

	ТаблицаСтатистики.Сортировать("ВремяВыполнения Убыв");

	Возврат ТаблицаСтатистики;

КонецФункции 

Функция ОписаниеТаблицы()

	ТаблицаСтатистики = Новый ТаблицаЗначений();
	Для Каждого ТекКолонка из ОписаниеКолонок Цикл
		ТаблицаСтатистики.Колонки.Добавить(ТекКолонка.Имя);
	КонецЦикла;
	
	Возврат ТаблицаСтатистики;

КонецФункции

Функция РаспарситьФайл(ПутьКФайлу)

	ЧтениеТекста = Новый ЧтениеТекста(ПутьКФайлу, КодировкаТекста.UTF8);
	Текст = ЧтениеТекста.Прочитать();

	ЧтениеЖСОН = Новый ЧтениеJSON;
	ЧтениеЖСОН.УстановитьСтроку(Текст);
	ДанныеСтатистики = ПрочитатьJSON(ЧтениеЖСОН, Истина);
	
	ЧтениеТекста.Закрыть();

	Возврат ДанныеСтатистики;

КонецФункции
