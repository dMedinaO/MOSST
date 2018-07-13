'''
script que recibe un archivo de alineamiento multiple y lo transforma al formato
de entrada del algoritmo MOSST...
'''

#modulos...
import os
import sys

#recibimos los archivos de entrada...
nameFile = sys.argv[1]
output = sys.argv[2]

#hacemos la lectura del archivo y almacenamos la informacion en una estructra de datos...
listData = []

fileRead = open(nameFile, 'r')
line = fileRead.readline()

while line:
    line = line.replace("\n", "")
    listData.append(line)
    line = fileRead.readline()

fileRead.close()

#obtenemos las posiciones de los header...
posHeader = []
for i in range(len(listData)):
    if listData[i][0] == ">":
        posHeader.append(i)

#hacemos la opertura del archivo...
fileWrite = open(output, 'w')

#comenzamos a formar la data final...
for j in range (len(posHeader)-1):

    line = ""
    #obtenemos el header...
    header = "(%s)" %(listData[posHeader[j]][1:])
    line = line+header
    if j< len(posHeader)-1:
        for i in range(posHeader[j]+1, posHeader[j+1]):
            #print listData[i]
            line = line+listData[i]
    fileWrite.write(line+"\n")
#me falta la linea secuencia final con su header...
line = "(%s)" %(listData[posHeader[-1]][1:])
for i in range(posHeader[-1]+1, len(listData)):
    line=line+listData[i]
fileWrite.write(line+"\n")
fileWrite.close()
