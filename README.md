# Introduction
- Cyclic voltammetry simulation of a redox-active film for a given set of dimensional parameters (concentration, diffusion coefficient of the electron, etc) which includes the effect of interactions between the redox-active moities. 
- The app is used in the course "Electrobiotechnology", taught by Prof. Dr. Nicolas Plumeré in the Professorship for Electrobiotechnology at the Technical University of Munich, Campus Straubing (TUMCS). A link to the group webpage can be found [here](https://ebt.cs.tum.de/?lang=en). The app is freely available and not restricted only for education and research purposes.
- Docker is used here because our group is currently exploring the possibility of deploying research apps using this platform. An in-depth presentation on this topic can be found [here](https://www.youtube.com/watch?v=L4nqky8qGm8).

# System Description Highlights
- No reactions, electron transfer in the film by means of hopping, characterized by the diffusion coefficient of the electron.
- Electron transfer at the electrode surface is characterized by Butler-Volmer kinetics.
- Can include capacitance contributions to the simulated signal by entering resistance and capacitance parameter values.
- Interactions within the film are included by means of the interaction parameter "g", based on the Frumkin isotherm. A full description is given in the following [paper](https://www.sciencedirect.com/science/article/pii/S0022072880804384). The default data set that comes with this app is based on figure 3 in this paper, however, not all parameters are exactly ths same, including an estimate of the heterogeneous rate constant which is based on a relevant follow-up [paper](https://www.sciencedirect.com/science/article/pii/036818748580068X). Although a general agreement is obtained, the default parameter data does not result in the exact replication of any CVs in the reference publication.
- Under certain experimental conditions (i.e. low scan-rates, very thin films, etc.), the resulting simulated signal for the film is comparable to that of an adsorbed monolayer. Therefore, if using equivalent values (i.e. equivalent coverage based on concentration multiplied by the film thickness), results can be quantitatively compared to adsorbed monolayer simulations which are described in the following [paper](https://www.sciencedirect.com/science/article/pii/S0022072879801679).
- Some of the plots which are presented in terms of scaled parameters, some of which are not part of the aforementioned papers. However, plots of dimensional current are provided so the use of scaled quantities is not required in order to obtain satisfactory agreement between an imported experimental CV and the simulated CV based on the given set of dimensional parameters. Time is referenced to the time required for a LSV in which the potential is swept +/- 200 mV around the standard potential of the redox couple. Concentration is referenced to its total value regardless of redox form. Space is referenced to the film thickness. Potential difference is referenced to (RT/nF), and current is referenced to the peak current that would be obtained for a reversible wave under semi-infinite conditions.

# App Demonstration Video
- A demo of the app is shown in a [video] for running the app on a windows 10 operating system.

# Results Obtained
- A plot of the spatial grid used for solving can also be obtained for purposes of tuning the solving parameters in order to gain satisfactory accuracy without sacrificing speed.
- An overlay plot of an imported experimental CV current signal with the simulated CV. This plot is dimensional.
- A composite overlay plot showing the contributions of faradaic and non-faradaic current (i.e. capacitive current). This is a panel figure with the dimensional and dimensionless versions next to each other.
- An animated video comprised of the simulated CV on the left side and an overlay plot of the concentration profiles on the right side. This is saved as an mp4 file in the user folder (i.e. ubuntu1804 or windows10). This is a plot of dimensionless current and concentrations.
- Current-potential data (dimensional and dimensionless) for the simulated CV, exported to an Excel file in the user folder (i.e. ubuntu1804 or windows10).
- A collection of calculated parameters useful for comparison to adsorbed monolayers (i.e. equivalent coverage, calculation of current scaling factor psi for the adsorbed monolayer system, etc.)
- The aforementioned plots can individually be chosen (or not chosen) by making the appropriate selections in the options tab of the parameters file.

# Typical Workflow
- Data from the experimental CV is copied/pasted into its respective tab of the parameter input file.
- Dimensional parameters (i.e. experimetal data, concentration, scan-rate, interaction parameter, etc.) are copied/pasted into its respective tabs of the parameter input file.
- Options related to plots and the solver are indicated in its respective tab of the parameter input file.
- If applicable, start up prerequiste supporting software (i.e. Docker, XLaunch).
- When starting the app, the location of the parameter file must be confirmed. This only needs to be done once per session.

# Operating Systems and Installation
- The app can be run from Windows 10 or from Ubuntu 18.04 LTS.
- The core of the simulation is carried out in a common Docker image, which is used by either the windows 10 or ubuntu 18.04 host operating system. Therefore, installation of docker is required. It is also necessary to register for a free docker account.
- The docker image requires use of the host screen infrastructure to show the simple graphical user interface menu and the plots on the screen. Therefore, on Windows 10 systems, installation of XLaunch is required. However, this is not required on Linux 18.04 systems.
- It is recommended that the installation of the prerequisites for this app (Docker and xLaunch) be performed by IT-support personnel or by advanced PC users (i.e. comfortable going into bios to change settings, using the command line, resolution of system-specific issues that might arise via google search and some troubleshooting).
- Installation and use of the app itself does not require any specialized computer knowledge once the prerequisites are fulfulled.
- Additional installation instructions which are operating system specific can be found within this project for [Windows 10](https://github.com/DLBuesen/redox-active-film-distribution-reversible/tree/main/project/windows10) and for [Ubuntu 18.04](https://github.com/DLBuesen/redox-active-film-distribution-reversible/tree/main/project/ubuntu1804).
- Demo videos of the [installation], [verification], and the [uninstallation](https://vimeo.com/562697627) of the app are also available to give a visual impression of what to expect in the process, but it will still be necessary to read the provided documentation.

# License
- This app was made using free open source software (Julia programming language). Therefore, usage is not restricted to teaching and research purposes.


