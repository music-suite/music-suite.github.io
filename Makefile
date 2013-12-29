
start:
	(python -m SimpleHTTPServer 5544)>/dev/null 2>&1 & echo "kill $$!;" > stop.sh &
	chmod a+x stop.sh
stop:         
	./stop.sh
	echo "echo \"Already stopped!\"" > stop.sh
	chmod a+x stop.sh
