#Использовать "../src/model"

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_СформироватьТелоЗапросаJira");

	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	
	УстановитьТекущийКаталог(ТекущийСценарий().Каталог);
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Процедура ТестДолжен_СформироватьТелоЗапросаJira() Экспорт
	
	ПровайдерИнтеграцииJira = Новый ПровайдерИнтеграцииJira()
												.URL("url")
												.Логин("login")
												.Токен("APIKey")
												.КлючПроекта("project-id")
												.ИдТипаЗадачи("1");


	ФайловоеХранилище = Новый ФайловоеХранилище("../features/fixtures/data");
	ДанныеОтчетаОбОшибке = ФайловоеХранилище.ПолучитьДанныеОтчетаОбОшибке("61001a5e-09d5-47b8-bf19-e7672eda10e5");
	
	Результат = ПровайдерИнтеграцииJira.СформироватьТелоЗапроса(ДанныеОтчетаОбОшибке);
	
	КаталогСценария = ТекущийСценарий().Каталог;
	ЧтениеТекста = Новый ЧтениеТекста("../features/fixtures/requestBodyJira.json", "utf-8");
	Эталон = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	Ожидаем.Что(Результат).Равно(Эталон);
	
КонецПроцедуры
