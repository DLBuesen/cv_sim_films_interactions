# Introduction
- Thickness distribution of a redox-active film by means of linear sweep voltammetry for a given set of dimensional parameters (peak currents, concentrations, diffusion coefficient of the electron, etc).
- The app is used in the course "Electrobiotechnology", taught by Prof. Dr. Nicolas Plumeré in the Professorship for Electrobiotechnology at the Technical University of Munich, Campus Straubing (TUMCS). A link to the group webpage can be found [here](https://ebt.cs.tum.de/?lang=en). However, the app is freely available for education and research purposes.
- Docker is used here because our group is currently exploring the possibility of deploying research apps using this platform. An in-depth presentation on this topic can be found [here](https://www.youtube.com/watch?v=L4nqky8qGm8).

# System Description Highlights
- By means of a series of linear sweep voltammetry experiments, the diffusion layer of the electron transfer within the film is varied. By comparison of this diffusion layer thickness to the external film boundaries, thickness distribution information can be obtained.
- Film thickness distributions are parameterized by the Weibull distribution. Changing the shape factor changes the entire shape of the resulting distribution, and does not merely make it narrower or wider, or move it to the left or to the right (i.e. the standard deviation and mean parameters of the normal distribution).
- As an ensemble method which probes the entire electrode surface, a representation of the entire film thickness distribution can be obtained. However, this method cannot determine the spatial positions of film sub-sections or aggregates. Therefore, this method is complementary to Atomic Force or Optical Microscopy, which can show the spatial arrangement and sizes of aggregates, but only for a limited portion of the electrode.
- Electron transfer within the film must be on the order of the time scale of a linear sweep voltammetry experiments (i.e. redox-hydrogel films); electron transfer within electrically conducting organic polymer films is to fast for use with this method.
- Counterion transport within the film is assumed to be non-rate limiting.
- Reversible electron transfer at the electrode (Nernst Equation) is assumed. This method cannot be used for the case of quasi-reveresible electron transfer.
- A full description of the system is given in the following research [paper](https://pubs.rsc.org/en/content/articlelanding/2020/sc/c9sc03653a#!divAbstract).

# App Demonstration Video
- A demo of the app is shown in a [video](https://vimeo.com/557098624) for running the app on a windows 10 operating system.

# Results Obtained
- Concentration and interaction parameter estimate values via calculations performed by the app.
- Non-dimensionalization of the user-entered peak currents for a series of scan rates based on end-user inputs, including estimates of average film thickness and the diffusion coefficient of the electron, etc.
- Automatic overlay of the dimensionless experimental data to results obtained for a series of shape factor values for easy and fast estimation of the film thickness distribution.
- The ability to fine tune the estimate for the film thickness distribution via custom calculations. 
- Probability distribution function of the resulting film thickness distribution along with a 3-dimensional representation for easy visualization (remembering that this is only a representation). The data points for the probability distribution function are saved in a newly created data export folder.
- Calculation of relevant statistics such as relative standard deviation, skewness, and kurtosis.

# Typical Workflow
- If applicable, start up prerequiste supporting software (i.e. Docker, XLaunch).
- Parameters are entered into the included excel file template and saved.
- When starting the app, the location of the parameter file must be confirmed. This only needs to be done once per session.
- The data and parameters file is filled out as much as possible to be able to obtain the initial plot.
- Based on the initial plot, scan-rates are chosen for the estimation of concentration (if applicable) and the interaction parameter. Information for these scan-rates is added to the necessary sheets within the excel workbook.
- Estimates of concentration (if applicable) and interaction parameter are obtained by the simulation. The value of the interaction parameter is tuned until the left side of the overlay plot aligns.
- By inspection of the resulting overlay plot, an estimate of the shape factor is already obtained. However, it is also possible to run a series of custom calculations for any specified value of the shape factor if necessary.
- After finalization of the shape factor value, the distribution, the representation, and the relevant statistics can be readily obtained by pressing the relevant buttons in the app.

# Operating Systems and Installation
- The app can be run from Windows 10 or from Ubuntu 18.04 LTS.
- The core of the simulation is carried out in a common Docker image, which is used by either the windows 10 or ubuntu 18.04 host operating system. Therefore, installation of docker is required. It is also necessary to register for a free docker account.
- The docker image requires use of the host screen infrastructure to show the simple graphical user interface menu and the plots on the screen. Therefore, on Windows 10 systems, installation of XLaunch is required. However, this is not required on Linux 18.04 systems.
- It is recommended that the installation of the prerequisites for this app (Docker and xLaunch) be performed by IT-support personnel or by advanced PC users (i.e. comfortable going into bios to change settings, using the command line, resolution of system-specific issues that might arise via google search and some troubleshooting).
- Installation and use of the app itself does not require any specialized computer knowledge once the prerequisites are fulfulled.
- Additional installation instructions which are operating system specific can be found within this project for [Windows 10](https://github.com/DLBuesen/redox-active-film-distribution-reversible/tree/main/project/windows10) and for [Ubuntu 18.04](https://github.com/DLBuesen/redox-active-film-distribution-reversible/tree/main/project/ubuntu1804).

# License
- This app was made using Matlab with an education and research license. Therefore, use of the app must be within the scope of this license.


