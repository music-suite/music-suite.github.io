
start:
	(python -m SimpleHTTPServer 5544)>/dev/null 2>&1 &
stop:
	killall python