#!/bin/bash

# A terminal window is opened and the commands are run with update messages

gnome-terminal --tab -- bash -c '\
	echo "Script is starting...";\
	echo ;\
	sleep 3;\
	echo "Checking docker login status...";\
	echo ;\
	sleep 3;\
	docker login;\
	echo ;\
	echo "Uninstalling the image...";\
	echo ;\
	sleep 3;\
	docker rmi dlbuesen/redox-active-film-distribution-reversible:version-1.0-layer-07;\
	sleep 3;\
	echo ;\
	echo "Confirming uninstallation of the docker image...";\
	echo ;\
	sleep 5;\
	echo "Docker image from repository";\
	echo "dlbuesen/redox-active-film-distribution-reversible";\
	echo "with tag"
 	echo "version-1.0-layer-07";\
	echo "should not appear in the list of images below";\
	echo ;\
	docker images;\
	echo ;\
	echo "Done";\
	echo ;\
sleep 60'
