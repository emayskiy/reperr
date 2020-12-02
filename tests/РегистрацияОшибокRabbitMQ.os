#Использовать "../src/model"

// BSLLS:UnusedParameters-off
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
// BSLLS:UnusedParameters-on
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_СформироватьТелоЗапросаRabbitMQ");

	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	
	УстановитьТекущийКаталог(ТекущийСценарий().Каталог);
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Процедура ТестДолжен_СформироватьТелоЗапросаRabbitMQ() Экспорт
	
	ПровайдерИнтеграцииRabbitMQ = Новый ПровайдерИнтеграцииRabbitMQ()
												.Пользователь("login")
												.Пароль("APIKey")
												.Сервер("project-id")
												.ВиртуальныйХост("1");

	ФайловоеХранилище = Новый ФайловоеХранилище("../features/fixtures/data");
	ДанныеОтчетаОбОшибке = ФайловоеХранилище.ПолучитьДанныеОтчетаОбОшибке("61001a5e-09d5-47b8-bf19-e7672eda10e5");
	
	Результат = ПровайдерИнтеграцииRabbitMQ.СформироватьТелоЗапроса(ДанныеОтчетаОбОшибке);
	
	КаталогСценария = ТекущийСценарий().Каталог;
	ЧтениеТекста = Новый ЧтениеТекста("../features/fixtures/requestBodyRabbitMQ.json", "utf-8");
	Эталон = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	Ожидаем.Что(Результат).Равно(Эталон);
	
КонецПроцедуры
