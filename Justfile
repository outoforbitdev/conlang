app_name := "conlang"

run: clean
    # Build image
    docker build -t {{app_name}} .
    # Run image
    docker run -d -p 1798:8080 --name {{app_name}} {{app_name}}
    # Wait for the server to start
    # docker container exec {{app_name}} wget http://localhost:5149 &> /dev/null
    # # Wait for the SPA development server to start
    # docker container exec {{app_name}} wget --no-check-certificate https://localhost:44446 &> /dev/null
    # Launch browser
    open https://localhost:1798

clean: stop
	-docker rmi {{app_name}}

stop:
	-docker stop {{app_name}}
	-docker rm {{app_name}}