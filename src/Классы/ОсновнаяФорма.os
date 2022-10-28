&Пластилин Перем ПарсерФайлаСтатистики Экспорт;
&Пластилин Перем СохраняторВФайл Экспорт;
&Пластилин Перем УправлениеФормами Экспорт;

Перем Форма;
Перем ОписаниеКолонок;
Перем СеткаДанных;
Перем ПредставлениеДанных;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("ОписаниеКолонокТаблицы") _ОписаниеКолонок 
							)
	
	ОписаниеКолонок = _ОписаниеКолонок;
	
КонецПроцедуры

Процедура ИнициализацияЭлементов()
	Форма = УправлениеФормами.Форма();
	Форма.Текст = "Анализ статистики выполнения кода OneScript";
	Форма.Отображать = Истина;
	Форма.Ширина = 855;
	Форма.Высота = 600;
	Форма.Показать();
	Форма.Активизировать();

	ГлавноеМеню = УправлениеФормами.ГлавноеМеню();
	Элементы = ГлавноеМеню.ЭлементыМеню;
	Подменю_Файл = Элементы.Добавить(УправлениеФормами.ЭлементМеню("Файл"));

	Элементы = Подменю_Файл.ЭлементыМеню;
	Подменю_Файл_Открыть = Элементы.Добавить(УправлениеФормами.ЭлементМеню("Открыть", УправлениеФормами.Действие(ЭтотОбъект, "Открыть_Нажатие")));
	Подменю_Файл_Сохранить = Элементы.Добавить(УправлениеФормами.ЭлементМеню("Сохранить", УправлениеФормами.Действие(ЭтотОбъект, "Сохранить_Нажатие")));

	Форма.Меню = ГлавноеМеню;

	ВывестиТаблицу();
КонецПроцедуры

Процедура ВывестиТаблицу()
	
	СеткаДанных = Форма.ЭлементыУправления.Добавить(УправлениеФормами.СеткаДанных());
	СеткаДанных.Стыковка = УправлениеФормами.СтильСтыковки.Заполнение;

	СтильТаблицыСеткиДанных1 = УправлениеФормами.СтильТаблицыСеткиДанных();
	СтильТаблицыСеткиДанных1.ИмяОтображаемого = "ТД1";
	СтилиКолонкиСеткиДанных1 = СтильТаблицыСеткиДанных1.СтилиКолонкиСеткиДанных;

	Для Каждого ТекКолонка из ОписаниеКолонок Цикл

		СтильКолонкиПолеВвода1 = УправлениеФормами.СтильКолонкиПолеВвода();
		СтильКолонкиПолеВвода1.ИмяОтображаемого = ТекКолонка.Представление;
		СтильКолонкиПолеВвода1.Ширина = ТекКолонка.Ширина;
		СтильКолонкиПолеВвода1.ТекстЗаголовка = ТекКолонка.Представление;
		СтильКолонкиПолеВвода1.Выравнивание = ТекКолонка.Выравнивание;

		СтилиКолонкиСеткиДанных1.Добавить(СтильКолонкиПолеВвода1);

	КонецЦикла;

	СеткаДанных.СтилиТаблицы.Добавить(СтильТаблицыСеткиДанных1);

КонецПроцедуры

Процедура ЗаполнитьТаблицуИзФайла(ПутьКФайлу)

	ТаблицаИзФайла = ПарсерФайлаСтатистики.ПрочитатьФайлВТаблицу(ПутьКФайлу);
	Форма.ПриостановитьРазмещение();

	ТаблицаДанных = УправлениеФормами.ТаблицаДанных("ТД1");
	Колонки1 = ТаблицаДанных.Колонки;

	Для Каждого ТекКолонка из ОписаниеКолонок Цикл
		Колонки1.Добавить(УправлениеФормами.КолонкаДанных(ТекКолонка.Представление, ТекКолонка.Тип));
	КонецЦикла;

	Для каждого ТекСтрока Из ТаблицаИзФайла Цикл
		НоваяСтрокаСтрока = ТаблицаДанных.Строки.Добавить(ТаблицаДанных.НоваяСтрока());	
		ЗаполнитьСтрокуДаных(НоваяСтрокаСтрока, ТекСтрока);
	КонецЦикла;

	ПредставлениеДанных = УправлениеФормами.ПредставлениеДанных();

	ПредставлениеДанных.НачатьИнициализацию();

	ПредставлениеДанных.Таблица = ТаблицаДанных;
	СеткаДанных.ИсточникДанных = ПредставлениеДанных;

	ПредставлениеДанных.ЗакончитьИнициализацию();

	СеткаДанных.ИсточникДанных = ПредставлениеДанных;

	Форма.ВозобновитьРазмещение();

КонецПроцедуры

Процедура ЗаполнитьСтрокуДаных(СтрокаТаблицаФормы, СтрокаИзФайла)
	Для Каждого ОписаниеКолонки Из ОписаниеКолонок Цикл
		СтрокаТаблицаФормы.УстановитьЭлемент(ОписаниеКолонки.Представление, СтрокаИзФайла[ОписаниеКолонки.Имя]);	
	КонецЦикла;
КонецПроцедуры

Процедура Открыть() Экспорт
	ИнициализацияЭлементов();
	УправлениеФормами.ЗапуститьОбработкуСобытий();	
КонецПроцедуры

Функция Открыть_Нажатие() Экспорт
	ДиалогОткрытияФайла = УправлениеФормами.ДиалогОткрытияФайла();
	ДиалогОткрытияФайла.Фильтр = "Файл json (*.json)|*.json";
	Если ДиалогОткрытияФайла.ПоказатьДиалог() = УправлениеФормами.РезультатДиалога.ОК  Тогда
		ЗаполнитьТаблицуИзФайла(ДиалогОткрытияФайла.ИмяФайла);
	КонецЕсли;
КонецФункции

Функция Сохранить_Нажатие() Экспорт
	ДСФ = УправлениеФормами.ДиалогСохраненияФайла();
	ДСФ.Фильтр = "Таблица в формате CSV (*.csv)|*.csv";
	Если ДСФ.ПоказатьДиалог() = УправлениеФормами.РезультатДиалога.ОК 
			И НЕ ПредставлениеДанных = Неопределено Тогда
		СохраняторВФайл.Записать(ПредставлениеДанных, ДСФ.ИмяФайла);       
	КонецЕсли;
КонецФункции