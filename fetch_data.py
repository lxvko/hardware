import json
import time
import requests
from uptime import uptime
from pydantic import BaseModel

# Формирование пустого словаря для данных
sensor_data = {
    "Load CPU Total": "",
    "Temperatures CPU Package": "",
    "Temperatures CPU Cores": "",
    "Clocks CPU Core #1": "",
    "Clocks CPU Core #2": "",
    "Clocks CPU Core #3": "",
    "Clocks CPU Core #4": "",
    "Clocks CPU Core #5": "",
    "Clocks CPU Core #6": "",
    "Data Memory Used": "",
    "Data Memory Available": "",
    "Load Memory": "",
    "Temperatures GPU Core": "",
    "Clocks GPU Core": "",
    "Clocks GPU Memory": "",
    "Load GPU Core": "",
    "Load D3D 3D": "",
    "Data GPU Memory Total": "",
    "Data GPU Memory Used": "",
    "Uptime": "",
}


# Формирование моделей для данных
class data(BaseModel):
    Text: str
    Value: str


class Child2(BaseModel):
    Text: str
    Children: list[data]


class Child1(BaseModel):
    Text: str
    ImageURL: str
    Children: list[Child2]


class Child(BaseModel):
    Text: str
    Children: list[Child1]


class Computer(BaseModel):
    Children: list[Child]


# Объявление переменной для адреса сервера
url = 'http://localhost:8085/data.json'


# Функция получения данных с сервера
def getData():
    # Формирование пункта Uptime для словаря данных
    Uptime = time.strftime("%H:%M:%S", time.gmtime(uptime()))
    sensor_data['Uptime'] = Uptime

    # Проверка работоспособности сервера
    try:
        response = requests.get(url=url)
        data = json.dumps(response.json(), indent=2)
    except requests.exceptions.ConnectionError:
        return 'RunHWMon'

    # Преобразование данных в модель библиотеки pydantic
    computer = Computer.parse_raw(data)
    parts = computer.Children[0].Children

    # Перебор компонентов компьютера с целью формирования словаря данных
    for part in parts:
        if part.ImageURL != 'images_icon/hdd.png':
            descriptions = part.Children
            for description in descriptions:
                if description.Text == 'Clocks':
                    datas = description.Children
                    for data in datas:
                        temp_data = f'Clocks {data.Text}'
                        if temp_data in sensor_data:
                            sensor_data[temp_data] = data.Value
                elif description.Text == 'Temperatures':
                    datas = description.Children
                    for data in datas:
                        temp_data = f'Temperatures {data.Text}'
                        if temp_data in sensor_data:
                            sensor_data[temp_data] = data.Value
                elif description.Text == 'Load':
                    datas = description.Children
                    for data in datas:
                        temp_data = f'Load {data.Text}'
                        if temp_data in sensor_data:
                            sensor_data[temp_data] = data.Value
                elif description.Text == 'Data':
                    datas = description.Children
                    for data in datas:
                        temp_data = f'Data {data.Text}'
                        if temp_data in sensor_data:
                            sensor_data[temp_data] = data.Value
        else:
            descriptions = part.Children
            for description in descriptions:
                if description.Text == 'Load':
                    datas = description.Children
                    for data in datas:
                        if data.Text == 'Used Space':
                            temp_data = f'Used Space {part.Text}'
                            sensor_data[temp_data] = data.Value
                if description.Text == 'Throughput':
                    datas = description.Children
                    for data in datas:
                        if data.Text == 'Read Rate':
                            temp_data = f'Read Rate {part.Text}'
                            sensor_data[temp_data] = data.Value
                        elif data.Text == 'Write Rate':
                            temp_data = f'Write Rate {part.Text}'
                            sensor_data[temp_data] = data.Value
    # На выходе функции получается словарь данных
    return sensor_data


# Если модуль запущен напрямую, то ничего не произойдет
if __name__ == "__main__":
    pass
