
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Если Элементы.Найти("ПересчитатьТаблицы") = Неопределено Тогда
		
		Команда = ЭтотОбъект.Команды.Добавить("ПересчитатьТаблицы"); 
		Команда.Заголовок = "Пересчитать таблицу";
		Команда.Действие ="ПересчитатьТаблицу";
		
		ЭлементКнопка = Элементы.Добавить("КнопкаПересчитатьТаблицу", Тип("КнопкаФормы"), ЭтотОбъект.Элементы.ГруппаШапкаЛево);
		ЭлементКнопка.ИмяКоманды = "ПересчитатьТаблицу";
		ЭлементКнопка.Вид = ВидКнопкиФормы.ОбычнаяКнопка;  
		
	КонецЕсли;   
	
	Если Элементы.Найти("СогласованнаяСкидка") = Неопределено Тогда  
		  
		  ДобавляемыеРеквизиты = Новый Массив;
		  
		  ТипРеквизита = Новый ОписаниеТипов("Строка");
		  
		  РеквизитКонтактноеЛицо = Новый РеквизитФормы("СогласованнаяСкидка", ТипРеквизита, "", "СогласованнаяСкидка");
		  
		  ДобавляемыеРеквизиты.Добавить(РеквизитКонтактноеЛицо);
		  
		 ИзменитьРеквизиты(ДобавляемыеРеквизиты); 
		  
		 НовыйЭлемент = Элементы.Добавить("СогласованнаяСкидка", Тип("ПолеФормы"),Элементы.ГруппаШапкаЛево);
		 НовыйЭлемент.ПутьКДанным = "Объект.СогласованнаяСкидка";
		 НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;   
		 НовыйЭлемент.УстановитьДействие("ПриИзменении", "СогласованнаяСкидкаПриИзменении")
		  
      КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
    
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СогласованнаяСкидкаПриИзменении(Элемент)
	
	ВсплывающийВопросПользователю()

КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ВсплывающийВопросПользователю()
	
	Оповещение = Новый ОписаниеОповещения("ПослеОтветаНаВопрос", ЭтотОбъект);
	ПоказатьВопрос(Оповещение, "Изменен процент скидки. Пересчитать таблицу товары и услуги?", РежимДиалогаВопрос.ДаНет);
		
КонецПроцедуры  

&НаКлиенте
Процедура ПослеОтветаНаВопрос(РезультатВопроса, ДополнительныеПараметры)  Экспорт  
	

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ПересчитатьСуммуТовары();
		ПересчитатьСуммуУслуги();
	Иначе 
		Возврат;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьСуммуТовары()
	                                                     		
	Для Каждого ЗначениеСписка Из Объект.Товары Цикл
		 							 	
		    РассчитатьСуммуСтроки(ЗначениеСписка);

	КонецЦикла;
	
КонецПроцедуры  

  &НаКлиенте
Процедура ПересчитатьСуммуУслуги()
	
	Для Каждого ЗначениеСписка Из Объект.Услуги Цикл
  					
	    РассчитатьСуммуСтроки(ЗначениеСписка);
	
	КонецЦикла;
	
КонецПроцедуры 



#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти


&НаКлиенте
Процедура ПересчитатьТаблицу(Команда)
	
	ПересчитатьСуммуТовары();
	ПересчитатьСуммуУслуги()

КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	Если (ТекущиеДанные.Скидка + Объект.СогласованнаяСкидка) > 100 Тогда 
		ТекущиеДанные.Сумма = 0;
		Сообщить("Проверьте установленную скидку");
		Возврат;
	КонецЕсли;
		
	ТекущиеДанные.Сумма = ТекущиеДанные.Количество * ( ТекущиеДанные.Цена - ТекущиеДанные.Цена * (Объект.СогласованнаяСкидка + ТекущиеДанные.Скидка)/ 100 );    
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
