@echo off

echo.

echo Starting script...
echo.

timeout 3

echo Uninstalling the docker container image...
echo.

timeout 3

docker rmi dlbuesen/cv_sim_films_interactions:version-1.1-layer07

timeout 3
echo Listing the installed docker images on the system...

timeout 3

docker images

timeout 3

echo Docker image from repository
echo "dlbuesen/cv_sim_films_interactions"
echo with tag "version-1.1-layer07"
echo should not appear in the list of images above
echo.

echo Done
echo.

pause
