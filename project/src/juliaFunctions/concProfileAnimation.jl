
using JLD
using PlotlyJS
using ORCA
    # Need ORCA when saving figures as png, needed to install it as a separate package


using Blink

function concProfileAnimation()

# sol is a global variable, so no need to load it or pass it. Couldn't save it in a jld file

    plotDataFileNameAndPath = "temp/plotData.jld"

#--------------------------------------------------------------
# Get the time and space points

    # Get the time points
    timePoints = sol.t ;
    numTimePts = size(sol)[3] ;

    # Get the number of space points
    numSpacePts = size(sol)[2] ;

    # Get the individual dimensionless space points
    dimensionless_x = load("temp/singleExpGridConcAtZero.jld", "xExpGrid0") ;

#--------------------------------------------------------------------
# Get the index points for each species

    # Number of species
    numMatBal = load("$plotDataFileNameAndPath", "numMatBal")
    #numMatBal = 2 ; # Already set and saved elsewhere, replace this later with reference.

    numSpacePtsPerSpecies = Int(numSpacePts/numMatBal) ;

    PoxSpaceIndexStart = 1 ;
    PoxSpaceIndexEnd = Int(numSpacePts/numMatBal) ;

#------------------------------------------------

# Initiate the Electron window. After initiation, the window is updated for the solution at each time point.

        timeIndex = 1 ;

		# Initial plot for current will be an overlay of the entire curve with a point with the current corresponding to the particular time point

		#-----Potential-Time

        dimensionlessTime = sol.t ;
		dimensionlessTime_dot = sol.t[timeIndex] ;

		epsilon_p = load("$plotDataFileNameAndPath", "epsilon_p") ;
		epsilon_p_dot = epsilon_p[timeIndex] ;

		#-----Current-Potential

		epsilon_p = load("$plotDataFileNameAndPath", "epsilon_p") ;
		FaradaicCurrent = load("$plotDataFileNameAndPath", "FaradaicCurrent") ;

        epsilon_p_dot = epsilon_p[timeIndex] ;
        FaradaicCurrent_dot = FaradaicCurrent[timeIndex] ;

		#-----Concentrations

        Pox = sol[1,PoxSpaceIndexStart:PoxSpaceIndexEnd,timeIndex] ;
        Pred = 1.0 .- Pox ;

# Plot in plotlyJS

#----------------------------------
# Prepare the panel figure for the first time point. The plots are prepared individually and then combined before sending to the Electron window

	#-----Prepare the individual time-potential plot

		epsilon_p_curve_trace = scatter(; x = dimensionlessTime, y = epsilon_p, mode="lines", name="Potential", line_color = "#051203", line_width = "2")

		epsilon_p_dot_trace = scatter(; x = dimensionlessTime[timeIndex:timeIndex], y = epsilon_p[timeIndex:timeIndex], mode="markers", name = "Potential", marker_color = "#a81100", marker_size="8")
			# plotInit_epsilon_p[$timeIndex:$timeIndex], can't just call plotInit_epsilon_p[$timeIndex] or else it won't plot. It possibly expecting a series of values instead of a single point.

		dlessPotential_data = [epsilon_p_curve_trace, epsilon_p_dot_trace] ;

		dlessPotential_layout = Layout(;
	        title="Dimensionless Potential Difference <br> TimeIndex = $timeIndex of $numTimePts ",
	        xaxis_range=[1.1*minimum(dimensionlessTime)-0.2, 1.1*maximum(dimensionlessTime)],
			yaxis_range=[1.1*minimum(epsilon_p), 1.1*maximum(epsilon_p)],
	  		xaxis=attr(title="Dimensioness Time"),
	  		yaxis=attr(title="Dimensioness (E-E0)")
	        )

		dlessPotential_Plot = plot(dlessPotential_data, dlessPotential_layout)

    #-----Prepare the individual dimensionless current plot

		# Colors from https://www.sessions.edu/color-calculator/

        dlessFarCurr_curve_trace = scatter(; x = epsilon_p, y = FaradaicCurrent, mode="lines", name="Current", line_color = "#051203", line_width = "2")

        dlessFarCurr_dot_trace = scatter(; x = epsilon_p[timeIndex:timeIndex], y = FaradaicCurrent[timeIndex:timeIndex], mode="markers", marker_color = "#a81100", marker_size="8")
            # plotInit_epsilon_p[$timeIndex:$timeIndex], can't just call plotInit_epsilon_p[$timeIndex] or else it won't plot. It possibly expecting a series of values instead of a single point.

        dlessFarCurr_data = [dlessFarCurr_curve_trace, dlessFarCurr_dot_trace] ;

		dlessFarCurr_layout = Layout(;
	        title="Dimensionless Current <br> TimeIndex = $timeIndex of $numTimePts ",
	        xaxis_range=[1.1*minimum(epsilon_p), 1.1*maximum(epsilon_p)],
			xaxis_tickmode = "array",
			xaxis_tickvals = [-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
			yaxis_range=[1.1*minimum(FaradaicCurrent), 1.1*maximum(FaradaicCurrent)],
			yaxis_tickmode = "array",
			yaxis_tickvals = [-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1],
	  		xaxis=attr(title="Dimensioness (E-E0)"),
	  		yaxis=attr(title="Dimensionless Current")
	        )

		dlessFarCurr_Plot = plot(dlessFarCurr_data, dlessFarCurr_layout)

    #-----Prepare the individual PoxPred plot

        # complementary color scheme from https://www.sessions.edu/color-calculator/
        # convert to rgb from https://www.rgbtohex.net/hextorgb/

        Pox_trace = scatter(; x=dimensionless_x, y = Pox, mode="lines", name="Pox", line_color = "rgb(15, 12, 62)", line_width = "3")

        Pred_trace = scatter(; x=dimensionless_x, y = Pred, mode="lines", name="Pred", line_dash = "dash", line_color = "rgb(62, 38, 12)", line_width = "3")

        PoxPred_data = [Pox_trace, Pred_trace] ;

        PoxPred_layout = Layout(;
        title="Pox and Pred Dimensionless Concentration Profile <br> TimeIndex = $timeIndex of $numTimePts ",
        yaxis_range=[0.0, 1.0],
        xaxis=attr(title="Dimensionless Distance"),
        yaxis=attr(title="Dimensionless Concentration")
        )

        PoxPred_Plot = plot(PoxPred_data,PoxPred_layout)

    #-----Prepare the first frame of the panel plot

        window_Width = 1225 ;
        window_Height = 530 ;

        global concProfilePanelPlot_Window = Blink.AtomShell.Window(
        Blink.shell(),
        Dict( :width=>window_Width,
              :height=>window_Height,
              :alwaysOnTop=>false,
              :title=>"Capturing Frames For Animation...",
              :resizable=>true,
              :x=>182,
              :y=>404
              );
        async=false)

        # Commands to get the window size and position after manually adjusting. After the optimal settings are determined, they can be set in the script before the window is created.

            # Blink.AtomShell.size(concProfilePanelPlot_Window)
            # Blink.AtomShell.position(concProfilePanelPlot_Window)

        dlessConcProfilePanel_Plot =  [dlessFarCurr_Plot PoxPred_Plot];

        Blink.body!(concProfilePanelPlot_Window, dlessConcProfilePanel_Plot; fade=false, async=false)

    #-----Save the first panel frame

        # Create the temporary folder for the animation frames. After the frames are used to construct the animation, they will be automatically deleted.

        animationFramesFolder = "animationFrames" ;

        if isdir("temp/$animationFramesFolder")==false
          mkdir("temp/$animationFramesFolder")
          display("Creating temp/$animationFramesFolder folder")
        else isdir("temp/$animationFramesFolder")==true
          display("temp/$animationFramesFolder folder already exists")
        end

        # Save the Plotly figure using the dimensions of the Electron window

        savefig(dlessConcProfilePanel_Plot,width=window_Width, height=window_Height,"temp/$animationFramesFolder/frame$timeIndex.png")


#------------------------------------------------------------------------
# Update the plot for all time points in a loop

    for i=2:numTimePts

          timeIndex_loop = i ;
          dimensionlessTime_loop = sol.t[timeIndex_loop] ;

          Pox_loop = sol[1,PoxSpaceIndexStart:PoxSpaceIndexEnd,timeIndex_loop] ;
          Pred_loop = 1.0 .- Pox_loop ;

		  # Update the potential difference plot title and traces

		  		# Update the title with the new time index and time value

				relayout!(dlessPotential_Plot, title="Dimensionless Potential Difference <br> TimeIndex = $timeIndex_loop of $numTimePts ")

				# Don't need to update the potential difference curve trace

				# Update the dot trace

				traceNumberToUpdate = 2 ;

				restyle!(dlessPotential_Plot, traceNumberToUpdate, x = [sol.t[timeIndex_loop:timeIndex_loop]], y = [epsilon_p[timeIndex_loop:timeIndex_loop]])

		  # Update the current plot title and traces

		  		# Update the title with the new time index and time value

		  		relayout!(dlessFarCurr_Plot, title="Dimensionless Current <br> TimeIndex = $timeIndex_loop of $numTimePts ")

				# Don't need to update the curve trace

				# Update the dot trace

				traceNumberToUpdate = 2 ;

				restyle!(dlessFarCurr_Plot, traceNumberToUpdate, x = [epsilon_p[timeIndex_loop:timeIndex_loop]], y = [FaradaicCurrent[timeIndex_loop:timeIndex_loop]])


          # Update the PoxPred plot title and traces

                # Update the title with the new time index and time value

                relayout!(PoxPred_Plot, title="Pox and Pred Dimensionless Concentration Profile <br> TimeIndex = $timeIndex_loop of $numTimePts ")

                # Update the concentration profile traces

                traceNumberToUpdate = 1 ;
                restyle!(PoxPred_Plot, [traceNumberToUpdate], y = [Pox_loop])

                traceNumberToUpdate = 2 ;
                restyle!(PoxPred_Plot, [traceNumberToUpdate], y = [Pred_loop])

          # Reform the panel plot

                dlessConcProfilePanel_Plot =  [dlessFarCurr_Plot PoxPred_Plot]
               

          # Update the Electron window

				Blink.body!(concProfilePanelPlot_Window, dlessConcProfilePanel_Plot; fade=false, async=false)

          # Save the frame

                # The size of the window is passed to the plot after the panel figure is constructed. Otherwise, the original sizes of the component plots

                savefig(dlessConcProfilePanel_Plot,width=window_Width, height=window_Height,"temp/$animationFramesFolder/frame$timeIndex_loop.png")

       end

# Convert the files to a mp4 movie


        paramsFileNameDirectory = load("temp/paramsFileDirectory.jld", "paramsFileNameDirectory") ;

        excelFileExportName = "ConcProfileAnimation.mp4"
    
        excelFileExportPath = paramsFileNameDirectory * excelFileExportName ;



		println("checking if .mp4 animation file already exists")
		if isfile("$excelFileExportPath")
			println("deleting old .mp4 animation file")
			run(`rm $excelFileExportPath`)
			sleep(2)
			run(`ffmpeg -i temp/$animationFramesFolder/frame%d.png $excelFileExportPath`)
		else
			println("creating new .mp4 animation file")
			run(`ffmpeg -i temp/$animationFramesFolder/frame%d.png $excelFileExportPath`)
		end

# Delete the frame files

        run(`rm -R temp/$animationFramesFolder`)

# Close the concentration profile electron window

        close(concProfilePanelPlot_Window)

end
