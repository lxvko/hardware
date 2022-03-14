asd = '3,9 GB'
dsa = '4,0 BB'

dataMemoryTotal = float((asd[:-3]).replace(',', '.')) + float((dsa[:-3]).replace(',', '.'))

print(dataMemoryTotal)