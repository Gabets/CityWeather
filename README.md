#  Задача:

## Создать приложение, которое будет показывать пользователю информацию о погоде в конкретном городе.

## Описание API - https://openweathermap.org/current

### Стори: При запуске приложения пользователю отображается экран 1. Пользователь вводит город, например - Moscow и нажимает кнопку "Показать погоду", происходит переход на экран 2, где отображается температура и описание (например - "Clouds"). Нажимая кнопку "Назад" пользователь попадает на экран 1.
*В случае, если ввести несуществующий город, при нажатии на кнопку "Показать погоду" должна отобразиться ошибка.

### Описание экранов:
1) В центре экрана поле для ввода города, под ним кнопка "Показать погоду".
2) В заголовке navigation bar отображается город и имеется кнопка "Назад". В центре экрана отображается температура(крупным шрифтом, градусы цельсия), под ней описание (например "Clouds").

* Ориентация: Вертикальная
* Архитектура на выбор: MVC, MVVM, VIPER
* Стек: swift, codable, alamofire
* Допускается: snapkit, rxcocoa, rxswift

### Пудет плюсом:
* Не использовать Storyboards
* Покрыть код тестами