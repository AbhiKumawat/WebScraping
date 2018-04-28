#Abhimanyu Kumawat
import os
import sys
import csv
import xml.dom.minidom 

#Read the argument and parse it to a document variable
file=(sys.argv[1])
stateString=sys.argv[1]
printState=stateString[20:22]

document = xml.dom.minidom.parse(sys.argv[1])

elements = document.getElementsByTagName('body')[0];
main=elements.getElementsByTagName('main')[0];
div=main.getElementsByTagName('div')[1];
tbody=div.getElementsByTagName("table")[0];
form=div.getElementsByTagName("h4")[0];
td=tbody.getElementsByTagName("td")[0];
weather=(div.getElementsByTagName("h4")[2].firstChild.nodeValue)
temperatureF=(div.getElementsByTagName("h1")[0].firstChild.nodeValue) #Celcius is [3]
humidity=(tbody.getElementsByTagName("td")[1].firstChild.nodeValue)
pre=(tbody.getElementsByTagName("td")[5].firstChild.nodeValue)
pre1=pre.strip()

with open("output.csv", "a") as csv_file:
	csv_app = csv.writer(csv_file)
	csv_app.writerow([printState, sys.argv[2], weather, temperatureF[0:2], humidity.strip("%"), pre1[0:5]])

#Removes file once done adding data to csv
os.remove(file)

