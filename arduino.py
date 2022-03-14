import time
from PySide6.QtSerialPort import QSerialPort, QSerialPortInfo
from PySide6.QtCore import QIODevice

serial = QSerialPort()
serial.setBaudRate(115200)
disk_list = []
selected = []


# Configuring the Arduino Port
def getPorts():
    portlist = []
    ports = QSerialPortInfo().availablePorts()
    for port in ports:
        portlist.append(port.portName())
    if len(portlist) == 0:
        portlist.append('None')
    return portlist


# Sending data to Arduino
def serialSendInt(data):
    if data[0] == 'info':
        data.pop(0)
        txs = '99|' + '|'.join(map(str, data)) + ';'
        serial.write(txs.encode())
    elif data[0] == 'print':
        data.pop(0)
        txs = '98|' + 'print' + ';'
        serial.write(txs.encode())
    elif data[0] == 'bye':
        data.pop(0)
        txs = '97|' + 'bye' + ';'
        serial.write(txs.encode())
    elif data[0] == 'hello':
        data.pop(0)
        txs = '95/' + '|'.join(map(str, data)) + ';'
        serial.write(txs.encode())


# Sending data to Arduino
def serialSendDict(data):
    ints = makeSelectedInt(selected, disk_list)
    ints.pop(0)
    for int in ints:
        val = takeWhatDoYouNeed(int, data)
        for i in val:
            i.replace(',', '.')
        print(val)
        txs = int + '|' + '|'.join(map(str, val)) + ';'
        serial.write(txs.encode())


# Open port button
def onOpen(port):
    serial.setPortName(port)
    serial.open(QIODevice.ReadWrite)
    hello = ['hello', '95']
    time.sleep(2)
    serialSendInt(hello)


# Make selected to int for Arduino
def makeSelectedInt(sel, disks):
    global disk_list
    global selected
    selected = sel
    disk_list = disks

    selected_int = ['info']

    if 'CpuLoad' in selected:
        selected_int.append('1')
    if 'CpuClocks' in selected:
        selected_int.append('2')
    if 'GpuLoad' in selected:
        selected_int.append('3')
    if 'GpuClocks' in selected:
        selected_int.append('4')
    if 'GpuMem' in selected:
        selected_int.append('5')
    if 'RamLoad' in selected:
        selected_int.append('6')
    if 'RamMem' in selected:
        selected_int.append('7')
    if 'Uptime' in selected:
        selected_int.append('8')
    try:
        if f'Used Space {disks[0]}' in selected:
            selected_int.append('9')
    except IndexError:
        pass
    try:
        if f'Used Space {disks[1]}' in selected:
            selected_int.append('10')
    except IndexError:
        pass
    try:
        if f'Used Space {disks[2]}' in selected:
            selected_int.append('11')
    except IndexError:
        pass
    try:
        if f'Rate {disks[0]}' in selected:
            selected_int.append('12')
    except IndexError:
        pass
    try:
        if f'Rate {disks[1]}' in selected:
            selected_int.append('13')
    except IndexError:
        pass
    try:
        if f'Rate {disks[2]}' in selected:
            selected_int.append('14')
    except IndexError:
        pass

    return selected_int


# Returns the data in the desired form
def takeWhatDoYouNeed(sel, data):
    match sel:
        case '1':
            return [data.get('Temperatures CPU Package').split(',')[0],
                    data.get('Load CPU Total').split(',')[0]]
        case '2':
            return [data.get('Clocks CPU Core #1')]
        case '3':
            return [data.get('Temperatures GPU Core').split(',')[0],
                    data.get('Load GPU Core').split(',')[0]]
        case '4':
            return [data.get('Clocks GPU Core').split(',')[0],
                    data.get('Clocks GPU Memory').split(',')[0]]
        case '5':
            return [data.get('Data GPU Memory Used').split(',')[0],
                    data.get('Data GPU Memory Total').split(',')[0]]
        case '6':
            return [data.get('Load Memory').split(',')[0]]
        case '7':
            dataMemoryTotal = float((data.get('Data Memory Available')[:-3]).replace(',', '.')) + float((data.get('Data Memory Used')[:-3]).replace(',', '.'))
            return [data.get('Data Memory Used'),
                    str(round(dataMemoryTotal, 1)) + ' GB']
        case '8':
            return ['Uptime: ' + data.get('Uptime')]
        case '9':
            return ['DiskSpace0: ' + data.get(f'Used Space {disk_list[0]}')]
        case '10':
            return ['DiskSpace1: ' + data.get(f'Used Space {disk_list[1]}')]
        case '11':
            return ['DiskSpace2: ' + data.get(f'Used Space {disk_list[2]}')]
        case '12':
            return ['DiskRead0  ' + data.get(f'Read Rate {disk_list[0]}').replace('/', ''),
                    'DiskWrite0 ' + data.get(f'Write Rate {disk_list[0]}').replace('/', '')]
        case '13':
            return ['DiskRead1  ' + data.get(f'Read Rate {disk_list[1]}').replace('/', ''),
                    'DiskWrite1 ' + data.get(f'Write Rate {disk_list[1]}').replace('/', '')]
        case '14':
            return ['DiskRead2  ' + data.get(f'Read Rate {disk_list[2]}').replace('/', ''),
                    'DiskWrite2 ' + data.get(f'Write Rate {disk_list[2]}').replace('/', '')]


if __name__ == "__main__":
    pass
