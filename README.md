<h1> Репозиторий устройства для получения сведений с аппаратных компонентов ПК </h1>

## Описание:

### Устройство предназначено для получения сведений о компонентах ПК, включая различную информацию о процессоре, оперативной памяти, жестком диске, видеокарте.

В данном репозитории хранится исходный код программы, которая позволяет получать информацию и отправлять ее на микроконтроллер, чертежи модели корпуса для устройства и прошивка для платформы Arduino.

В ходе разработки использовались следующие компонеты:

1. Платформа Arduino Nano;
2. LCD2004 с IIC конвертером;
3. Небольшое количество проводов.

Для подключения вышеперечисленных компонентов вам необходимо соответствовать следующим правилам подключения: 

- GND -> GND;
- VCC -> 5V;
- SDA -> A4;
- SCL -> A5;

---
## Инструкция к использованию:

    Для начала необходимо подключить платформу Arduino и прошить её файлом, из папки arduino. 
    
Сделать это можно специальной программой IDE, которую можно скачать с официального сайта Arduino.

    Далее вам необходимо запустить программу LibreHardwareMonitor.

Установить ее можно как из - [официального репозитория](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor), так и использовать из данного.

    Далее необходимо убедиться, что программа запустила работу выделенного локального сервера.

Для этого необходимо проследовать по пунктам: <br>
Options -> Remote Web Server -> Run

После этого по адресу `localhost:8085` вы получите страницу с информацией о компонентах ПК.

    Следующим шагом будет запуск программы из папки output.

Программа имеет большой выбор параметров, которые можно отправлять на микроконтроллер.

Когда вы определитесь с тем, что хотите отобразить на дисплее микроконтроллера, нажмите на выпадающий список с портами, `Choose` и на название порта, который используется платформой Arduino.

Далее нужно нажать на кнопку `Open`. Это установит связь между компьютером и микроконтроллером. <br/> 
На экране микроконтроллера должно появиться приветствие.

Последним шагом будет нажатие на кнопку `Apply`. <br/>
Это начнет работу программы и вы сможете увидеть необходимый результат на экране микроконтроллера.

---
## Возможные трудности при использовании

### Разблокировка и выбор для мониторинга желаемого накопителя данных может показаться непонятной из-за неявной выборки параметров.

Для разблокировки необходимо включить соответствующий параметр, однако пока не будет выбрано что-то из выпадающего меню - ничего выбрано не будет.

Работа выпадающего меню представлена выпадающим списком с неявными чекбоксами. <br/>

`Единичное нажатие` на название накопителя `выбирает его` для мониторинга. <br/>

`Повторное нажатие` на название накопителя `отменяет его выбор`.

Такая реализация является принужденной, поскольку стандартные средства разработки не предоставляют возможность добавлять выпадающий список с явными чекбоксами.

### Выбор порта для отправки данных на микроконтроллер может показаться непонятным из-за неявной выборки параметров

Обновление выпадающего списка с текущими доступными портами обновляется лишь единожды при первом открытии программы.

Это приводит к тому, что при подключении устройства, когда программа уже открыта - устройство не будет отображено в списке подключенных.

Для решения этой проблемы необходимо перезагрузить программу.