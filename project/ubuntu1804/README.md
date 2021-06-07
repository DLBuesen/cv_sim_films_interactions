# Minimum Computer Specifications
- At least 8 GB of RAM
- CPU equivalent to at least i5 generation 8
- 50 GB free on the hard drive. Solid state drives are not required but will have better performance.
- Stable internet connection to be able to download the containers, which can be as large at 9.5 GB (i.e. preferable use DSL cable rather than WiFi).

# Operating System Specifications
- Updated ubuntu 18.04
- Local (i.e. not a web or cloud based) installation of Open Office Calc
- Admin level (i.e. sudo) privileges.

# Back up Your Data
- Back up your data to an external device, i.e. not a separate partition on the same hard-drive.
- This is standard good practice and should always be done before starting any installation or making any major changes to your PC.

# App Prerequisites
- Docker engine must be installed to be able to run docker container images. Instructions for installation of docker engine for the ubuntu operating system can be found in the Docker software [documentation](https://docs.docker.com/engine/install/ubuntu/).
- Register for a free docker [account](https://www.docker.com/).
- For convenience, Ubuntu 18.04 can be configured to run bash scripts via double-click. However, this is not required for using the app.

# Installing the App
- Download the project folder from this repositry and unzip to any location on your computer.
- Run the docker container installation script in the "docker" folder. Signing into your docker account can be done directly during the running of the scripts via keyboard entry if not already done. Any Matlab-based app requires the use of Matlab runtime, which is unfortunately over 9GB in size. Therefore, installation of the container might take as long as 10 minutes.
- After setting the paths for the parameter and data export excel files, run the simulation with the preset parameter values. Verify that the reults match what is presented in the installation video.
- Change parameters, save, and rerun the simulation, to confirm that the connection to the parameter input export excel files is working. The excel file must be saved each time after a change or the app will not capture it.

# Uninstalling the App
- To uninstall, run the uninstallation script in the "containers" folder, and follow the instruction in the prompt to verify that the container has been removed.
- Move the project folder to the recycling bin.


