# Minimum Computer Specifications
- At least 8 GB of RAM. However, since docker uses virtualization, and will automatically assign a portion of the RAM to the virtual container, 16 GB of RAM is better.
- CPU equivalent to at least i5 generation 8.
- 50 GB free on the hard drive. Solid state drives are not required but will have better performance.
- Stable internet connection to be able to download the containers, which can be as large at 9.5 GB (i.e. preferable use DSL cable rather than WiFi).

# Operating System Specifications
- Fully updated windows 10 (home, educational, or professional)
- Local (i.e. not a web or cloud based) installation of Excel.
- Admin privileges. If the account does not have admin privileges, then the system admin will need to perform the installation for you.

# Back up Your Data
- Back up your data to an external device, i.e. not a separate partition on the same hard-drive.
- This is standard good practice and should always be done before starting any installation or making any major changes to your PC.

# Prerequisite Steps and Software
- Enable virtualization on your computer via change in bios settings. The following [video](https://www.youtube.com/watch?v=MOuTxfzCvMY) illustrates what is meant by this and shows an example. Another [video](https://www.youtube.com/watch?v=wlfS0UEMUqc) gives another example for a more complicated case.
- Install Windows System for Linux version 2 which is described in the following [video](https://www.youtube.com/watch?v=_fntjriRe48).
- Install Docker Desktop and configure it to run Linux based containers via WSL 2 as described in the following [video](https://www.youtube.com/watch?v=5RQbdMn04Oc).
- Install VcXsrv Windows X Server (XLaunch) as described in the following [video](https://www.youtube.com/watch?v=YbXDJJE5zsc).
- Prior to installing and using the app, it is required to startup Docker Desktop, logging into your account. It is also necessary to start an XLaunch session.

# Installing the App
- Download the project folder from this repository and unzip to any location on your computer. Close as many programs as possible and use your computer as little as possible during the installation.
- Verify that docker desktop is running, that you are signed into your docker account, and that docker is set for running linux based containers. 
- Run the docker container installation script in the "containers" folder. If your system already has a similar docker container image installed from another similar app, then the installation should be rather fast. Otherwise, due to the large size of the container (i.e. 10 GB or so), expect installation to take as long as 10 minutes. To minimize the possibility of interruptions during download, it is recommended to download the container over a DSL cable connection rather than via WiFi.
- Restart your computer after the installation because a windows specific virtualization process "vmmem" tends to take up nearly all RAM for some reason while the docker image is installed, but this is no longer an issue after the systme is rebooted.

# Running the App and Verifying Correct Installation
- Start an XLaunch session by keeping all of the defaults, except that access control should be disabled.
- Run the launchApp script in the "windows10" folder and follow the instructions.
- Follow the instructions of the startup script to enter the screen number assigned by XLaunch. Most of the time, the default is 0, but not always, so most of the time one can simply type 0 in the launch script and move on. If necessary, however, the display number that is assigned can be found by hovering over the xLaunch icon in the task tray; the display number is the last number (i.e. Desktop-ABCXYZ:0.0 in which case the display is 0). Including this option in the start up script also gives flexibility for users who have multiple screens, because it allows for the possibility of manually assigning a screen while initiating the XLaunch session and then pointi the output of the app to that particular screen.
- Follow the instructions to enter the virtual Ip4 "Ipv4" address for your computer, and enter the display number during the app launch process. This Ip address is the virtual IP address that your computer uses to communicate with docker and is not the IP address that your computer uses for accessing the world wide web.
- After setting the paths for the parameter and data export excel files, run the simulation with the preset parameter values.  Verify that the resulting plot matches the results shown in the demonstration video.
- Change one of the parameters, save the Excel file, and rerun the simulation to verify that the result changes. If the Excel file is not saved after changes, then the app will not be able to recognize the changes.
- Close Docker and XLaunch.

# Uninstalling the App
- Verify that Docker Desktop is started and that you are logged into your account.
- Run the uninstallation script in the docker folder, and follow the instructions to verify that the container has been removed.
- Move the project folder to the recycling bin.
- Close Docker Desktop.
