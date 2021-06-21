#!/bin/bash

# A terminal window is opened and the commands are run with update messages

gnome-terminal --tab -- bash -c '\
	echo "Starting the app...";\
	echo ;\
	sleep 3;\
	cd $(dirname "$0");\
	cd ..;\
	sleep 3;\
	docker login;\
	echo ;\
	sleep 3;\
	xhost + && docker run --rm -ti --entrypoint="/usr/bin/julia-1.4.2/bin/julia" --user nonroot -e DISPLAY=$DISPLAY -p 127.0.0.1:8000:8000 -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $(pwd):/home/nonroot/project -w /home/nonroot/project/src dlbuesen/cv_sim_films_interactions:version-1.1-layer07'

