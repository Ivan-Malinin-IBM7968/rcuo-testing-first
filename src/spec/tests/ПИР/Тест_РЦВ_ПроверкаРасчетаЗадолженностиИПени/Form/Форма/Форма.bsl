﻿
&НаСервере
Процедура ПолучитьТДНаСервере(ТабДок)
	
	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000084360");
	ДатаРасчета = Дата(2016,11,25);
	НачалоПериода = Дата(1,1,1);
	КонецПериода = Дата(2016,10,31);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000001003");
	рцПИРаботаСервер.ПолучитьБлокДанныхДляСправкиПоЗадолженности(СтруктураДанных, ЛицевойСчет, ДатаРасчета, НачалоПериода, КонецПериода, ,НаборВидовРасчета);
	
	пОбъект = РеквизитФормыВЗначение("Объект");
	пОбъект.ВыводДЗвТД(СтруктураДанных.ДетализацияПоЗадолженности, ТабДок);		
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьТД(Команда)
	ТабДок = Новый ТабличныйДокумент;
	ПолучитьТДНаСервере(ТабДок);
	ТабДок.Показать();
КонецПроцедуры

&НаСервере
Процедура ПолучитьТД_ПениНаСервере(ТабДок)
	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000084360");
	ДатаРасчета = Дата(2016,11,25);
	НачалоПериода = Дата(1,1,1);
	КонецПериода = Дата(2016,10,31);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000001003");
	УК = Справочники.Контрагенты.НайтиПоНаименованию("ООО ""Уютный дом""");
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Ссылка",Документы.рцРаботаСИсками.ПустаяСсылка());
	ПараметрыОтбора.Вставить("Тип",Перечисления.рцВидыДокументовПИР.ПустаяСсылка());
	ПараметрыОтбора.Вставить("ДатаРасчета",ДатаРасчета);
	ПараметрыОтбора.Вставить("ДатаМероприятий",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаДвиженияИсков",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРаботыСИскам",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРеестраДебиторов",Дата(1,1,1));
	ПараметрыОтбора.Вставить("НаборВидовРасчета",НаборВидовРасчета);
	ПараметрыОтбора.Вставить("ТипДокумента",Перечисления.рцТипыОперацийПодачаИска.СудебныйПриказ);
	ПараметрыОтбора.Вставить("НачалоПериода",НачалоПериода);
	ПараметрыОтбора.Вставить("КонецПериода",КонецПериода);
	ПараметрыОтбора.Вставить("СрокЗадолженности",0);
	ПараметрыОтбора.Вставить("СуммаОсновногоДолга",0);
	ПараметрыОтбора.Вставить("ТарифСудебныхРасходов",0);
	ПараметрыОтбора.Вставить("УК",УК);
	
	// Использовать ежемесячное начисления пени
	ПараметрыОтбора.Вставить("НаборВидовРасчетаПени", Неопределено);
	ПараметрыОтбора.Вставить("ИспользоватьНачисленнуюПеню", Ложь);
									
	ПараметрыОтбора.Вставить("ЛицевыеСчета",ЛицевойСчет);	
	Состав = Неопределено;
	рцПИРаботаСервер.ЗаполнитьСоставДолжниковПоПараметрамОтбора(Состав,ПараметрыОтбора);
	
	пОбъект = РеквизитФормыВЗначение("Объект");	
	пОбъект.ВыводПрямогоРезультатвТД(Состав, ТабДок);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьТД_Пени(Команда)
	ТабДок = Новый ТабличныйДокумент;
	ПолучитьТД_ПениНаСервере(ТабДок);
	ТабДок.Показать();
КонецПроцедуры


