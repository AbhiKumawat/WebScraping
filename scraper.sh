#!/bin/bash
#Abhimanyu Kumawat
printf '%s\n' State,City,Weather,Temperature,Humidity,Pressure | paste -sd ' ' >> output.csv
while [ 1 ]
do
	varNY=`date +%Y-%m-%d-%H-%M-%S-NY`
	varCA=`date +%Y-%m-%d-%H-%M-%S-CA`
	varIL=`date +%Y-%m-%d-%H-%M-%S-IL`
	varTX=`date +%Y-%m-%d-%H-%M-%S-TX`
	varAZ=`date +%Y-%m-%d-%H-%M-%S-AZ`
	varPA=`date +%Y-%m-%d-%H-%M-%S-PA`
	varFL=`date +%Y-%m-%d-%H-%M-%S-FL`

	curl "https://forecast-v3.weather.gov/point/40.78,-73.97?view=plain" -o $varNY.html 	#NY, New York: 40.78,-73.97
	curl "https://forecast-v3.weather.gov/point/34.02,-118.45?view=plain" -o $varCA.html 	#CA, Los Angeles: 34.02,-118.45
	curl "https://forecast-v3.weather.gov/point/41.78,-87.76?view=plain" -o $varIL.html 	#IL, Chicago: 41.78,-87.76
	curl "https://forecast-v3.weather.gov/point/29.64,-95.28?view=plain" -o $varTX.html 	#TX, Houston: 29.64,-95.28
	curl "https://forecast-v3.weather.gov/point/33.69,-112.07?view=plain" -o $varAZ.html 	#AZ, Phoenix: 33.69,-112.07
	curl "https://forecast-v3.weather.gov/point/40.08,-75.01?view=plain" -o $varPA.html 	#PA, Philadelphia: 40.08,-75.01
	curl "https://forecast-v3.weather.gov/point/30.23,-81.67?view=plain" -o $varFL.html 	#FL, Jacksonville: 30.23,-81.67
	
	#Converts HTML to XHTML and the second one deletes the html extension files
	for file in *; do
	if [ ${file: -5} == ".html" ]
	then
		echo "Converting $file to .xhtml"
		java -jar tagsoup-1.2.1.jar --files $file
	fi
	done
	
	for file in *; do
	if [ ${file: -5} == ".html" ]
	then
		echo "Deleting $file"
		rm $file
	fi
	done
	
	#python3 xhtmlToCsv.py $file
	#Passes the XHTML files to python code
	for file in *
	do
		if [ ${file: -6} == ".xhtml" ]
		then
			if [[ $file = *"NY"* ]]; then
			  python3 xhtmlToCsv.py $file "New York"
			fi
			if [[ $file = *"AZ"* ]]; then
			  python3 xhtmlToCsv.py $file "Phoenix"
			fi
			if [[ $file = *"PA"* ]]; then
			  python3 xhtmlToCsv.py $file "Philadelphia"
			fi
			if [[ $file = *"TX"* ]]; then
			  python3 xhtmlToCsv.py $file "Houston"
			fi
			if [[ $file = *"CA"* ]]; then
			  python3 xhtmlToCsv.py $file "Los Angeles"
			fi
			if [[ $file = *"FL"* ]]; then
			  python3 xhtmlToCsv.py $file "Jacksonville"
			fi
			if [[ $file = *"IL"* ]]; then
			  python3 xhtmlToCsv.py $file "Chicago"
			fi
		fi
	done
	sleep 3600s	
done
