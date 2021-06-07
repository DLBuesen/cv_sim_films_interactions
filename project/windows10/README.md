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
- Download the project folder from this repository and unzip to any location on your computer.
- Close as many programs as possible and use your computer as little as possible during the installation. A restart might be required because a windows specific virtualization process "vmmem" tends to take up nearly all RAM for some reason while the docker image is installed if it is the first time that the image is installed and there are no other similar images already installed. However, after the system is restarted after the installation, the computer RAM usage is once again normal. If your system already has a similar docker container image installed from another similar app, then the installation should not only be very fast, but should also not have vmmem problems, and a restart should not be required.
- Verify that docker desktop is running, that you are signed into your docker account, and that docker is set for running linux based containers.
- Run the docker container installation script in the "containers" folder.

# Running the App and Verifying Correct Installation
- Start an XLaunch session with access control disabled. Note the display number that is assigned by hovering over the icon after launch (i.e. Desktop-BN8H7BC:0.0 in which case the display is 0.0). Most of the time, the default is 0.0, but not always, so this step is included for robustness. It also allows flexibility for users who have multiple screens, because it allows for the possibility of pointing the output of the app to a screen which is manually assigned while the XLaunch session is started.
- Run the launchApp script in the "windows10" folder. Follow the instructions to enter the virtual Ip4 "Ipv4" address for your computer, and enter the display number during the app launch process.
- After setting the paths for the parameter and data export excel files, run the simulation with the preset parameter values. Verify that the resulting plot matches the results shown in the demonstration video.
- Change one of the parameters, save the Excel file, and rerun the simulation to verify that the result changes. If the Excel file is not saved after changes, then the app will not be able to recognize the changes.
- Close docker and XLaunch.

# Uninstalling the App
- Verify that Docker desktop is started any you are logged into your account.
- Run the uninstallation script in the dockerfolder, and follow the instruction in the prompt to verify that the container has been removed.
- Move the project folder to the recycling bin.
- Close Docker desktop.
