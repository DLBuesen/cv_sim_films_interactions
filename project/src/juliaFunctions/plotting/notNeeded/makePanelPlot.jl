cd("/home/tadeus/Documents/SS2021/115_CV_Simulation_Julia/100_22Feb2021/juliaFunctions/plotting")

using JLD
using PlotlyJS
using Blink


# sol is a global variable, so no need to load it or pass it.


# Get the time points

timePoints = sol.t ;
numTimePts = size(sol)[3] ;

# Get the number of space points
numSpacePts = size(sol)[2] ;

# Number of species
numMatBal = 2 ; # Already set and saved elsewhere

# Get the index points for each species

numSpacePtsPerSpecies = Int(numSpacePts/numMatBal) ;

PoxSpaceIndexStart = 1 ;
PoxSpaceIndexEnd = Int(numSpacePts/numMatBal) ;

YoxSpaceIndexStart = PoxSpaceIndexEnd + 1 ;
YoxSpaceIndexEnd = numSpacePts ;

#----------------------------------------------------------------

# Get Pox conc profile (all space points) at a given time point

timeIndex = 100 ;
dimensionlessTime = sol.t[timeIndex] ;
Pox = sol[1,PoxSpaceIndexStart:PoxSpaceIndexEnd,timeIndex] ;
    # Results in an array
    # Pox = transpose(Pox) ; # To convert to a row matrix
Pred = 1.0 .- Pox ;
println("Pox at time index $timeIndex of $numTimePts total and dimensionless time $dimensionlessTime = $Pox")
println("")
plot(Pox)
Yox = sol[1,YoxSpaceIndexStart:YoxSpaceIndexEnd,timeIndex] ;
#println("Yox at time index $timeIndex of $numTimePts total and dimensionless time $dimensionlessTime = $Yox")
#println("")
#plot(Yox)

# Plot in plotlyJS

Pox_trace = scatter(; y = Pox, mode="lines", line_dash = "dashdot", name="Pox", line_color = "rgb(204, 170, 0)", line_width = "3")
#Pox_trace = scatter(; y = Pox, mode="lines", line_dash = "dashdot", name="Pox", line_color = "ForestGreen", line_width = "3")


Pred_trace = scatter(; y = Pred, mode="lines", name="Pred", line_dash = "dash", line_color = "rgb(124, 10, 2)", line_width = "4")

Yox_trace = scatter(; y = Yox, mode="lines", name ="Yox", line_color = "rgb(169, 169, 169)", line_width = "5")

# data = [Pox_trace,Pred_trace,Yox_trace] ;
data = [Pox_trace] ;
# data = [Pred_trace] ;
# data = [Yox_trace] ;

layout = Layout(;title="Pred Conc Profile <br> TimeIndex = $timeIndex of $numTimePts ",
xaxis=attr(title="Dimensionless Distance"),
yaxis=attr(title="Dimensionless Concentration")
)

# Plots in Atom Plots pane as well, but needed for plotting in PlotlyJS
Pox_Plot = plot(data,layout)


layout = Layout(;title="Pox Conc Profile <br> TimeIndex = $timeIndex of $numTimePts ",
xaxis=attr(title="Dimensionless Distance"),
yaxis=attr(title="Dimensionless Concentration")
)
data = [Pred_trace] ;
Pred_Plot = plot(data,layout)


global dimensionlessConcProfileOverlay_Plot_Window = Blink.AtomShell.Window(
Blink.shell(),
Dict(  :width=>695,
      :height=>510,
      :alwaysOnTop=>false,
      :title=>"Dimensionless Concentation Profiles",
      :resizable=>true,
      :x=>731,
      :y=>250
      );
async=false)

Blink.body!(dimensionlessConcProfileOverlay_Plot_Window,[Pox_Plot Pred_Plot]; fade=false, async=false)

#------------------------------------------------------------------------
# Update the plot

# sleep(1)
#
# relayout!(dimensionlessConcProfileOverlay_Plot, title = "New Title")
# #restyle!(dimensionlessConcProfileOverlay_Plot, title = "New Title")
#
# Blink.body!(dimensionlessConcProfileOverlay_Plot_Window,dimensionlessConcProfileOverlay_Plot; fade=false, async=false)
#
# sleep(1)
#
# restyle!(dimensionlessConcProfileOverlay_Plot, line_color = "ForestGreen")
#
# Blink.body!(dimensionlessConcProfileOverlay_Plot_Window,dimensionlessConcProfileOverlay_Plot; fade=false, async=false)
#
# sleep(1)
#
# PoxUpdated = Pox .* 0.5 ;
# traceNumberToUpdate = 1 ;
#
# restyle!(dimensionlessConcProfileOverlay_Plot, [traceNumberToUpdate], y = [PoxUpdated])
#
# Blink.body!(dimensionlessConcProfileOverlay_Plot_Window,dimensionlessConcProfileOverlay_Plot; fade=false, async=false)
#
#
#





















# Making it a loop

# numTimePtsForPlot = 2 ;
#
# PoxDataForPlot = zeros(numTimePtsForPlot,(numTimePtsForPlot*numSpacePtsPerSpecies)) ;
# println("PoxDataForPlot=$PoxDataForPlot")
#
# for i = 1:numTimePtsForPlot
#     timeIndex = i
#     dimensionlessTime = sol.t[timeIndex]
#     PoxForPlot[] = sol[1,:,timeIndex]
#     Pred = 1.0 .- Pox
#     println("Pox at time index $timeIndex of $numTimePts total and dimensionless time $dimensionlessTime = $Pox")
#     println("")
#     plot(Pox)
# end


# clearconsole()



#cd("/home/tadeus/Documents/SS2021/115_CV_Simulation_Julia/100_22Feb2021/juliaFunctions")

#function plotConcProfile()


# # Loading the data
#     plotDataFileNameAndPath = "../temp/plotData.jld"
#     numPts = load("$plotDataFileNameAndPath", "numPts")
#     #solArray = load("$plotDataFileNameAndPath", "solArray")
#     numTimePts = load("$plotDataFileNameAndPath", "numTimePts")
#     timePts = load("$plotDataFileNameAndPath", "t")
#     PoxExtracted = load("$plotDataFileNameAndPath", "PoxExtracted")
#     YoxExtracted = load("$plotDataFileNameAndPath", "YoxExtracted")
#
#     timePointForTrace1 = 1 ;
#
#     timePointForTrace2 = 75 ;
#
#     timePointForTrace3 = 100 ;
#
#     # To access the concentrations for Pox or Yox at time point 150
#     # PoxExtracted[:,150]
#     # YoxExtracted[:,150]
#
#     PoxTrace1 = PoxExtracted[:,timePointForTrace1]
#     PoxTrace2 = PoxExtracted[:,timePointForTrace2]
#     PoxTrace3 = PoxExtracted[:,timePointForTrace3]
#
#
#     xPointsForPlot = 1:numPts
#
#     # Form the plot
#
#       	  trace1 = scatter(; x = xPointsForPlot, y = PoxTrace1, mode="lines", name="Trace1", marker_color = "rgb(169,169,169)", line_width = "5")
#
#       	  trace2 = scatter(; x = xPointsForPlot, y = PoxTrace2, mode="lines", name ="Trace2", line_dash = "dash", line_color = "rgb(0,72,186)", line_width = "3")
#
#           trace3 = scatter(; x = xPointsForPlot, y = PoxTrace3, mode="lines", name ="Trace3", line_dash = "dash", line_color = "rgb(0,72,186)", line_width = "3")
#
#           #
#           # trace1 = scatter(; y = PoxTrace1, mode="lines", name="Trace1", marker_color = "rgb(169,169,169)", line_width = "5")
#           #
#       	  # trace2 = scatter(; y = PoxTrace2, mode="lines", name ="Trace2", line_dash = "dash", line_color = "rgb(0,72,186)", line_width = "3")
#           #
#           # trace3 = scatter(; y = PoxTrace3, mode="lines", name ="Trace3", line_dash = "dash", line_color = "rgb(0,72,186)", line_width = "3")
#
#
#       		data = [trace1,trace2,trace3] ;
#
#     	  	layout = Layout(;title="Conc Profile <br> Pox",
#     	  	xaxis=attr(title="Position"),
#     	  	yaxis=attr(title="Concentration"),
#             yaxis_range=[0, 1],
#     	  	)
#
#       		conc_Profile_Plot = plot(data,layout)
#
#     	  	global conc_Profile_Plot_Window = Blink.AtomShell.Window(
#     		Blink.shell(),
#     		Dict(  :width=>695,
#     				:height=>510,
#     				:alwaysOnTop=>false,
#     				:title=>"Conc Profile",
#     				:resizable=>true,
#     				:x=>731,
#     				:y=>250
#     				);
#     		async=false)
#
#       		Blink.body!(conc_Profile_Plot_Window,conc_Profile_Plot; fade=false, async=false)
#
#
#
# # Trying to refresh the plot
#
#     p = plot([scatter(x = xPointsForPlot, y=PoxTrace1, name="Trace1"),
#               scatter(x = xPointsForPlot, y=PoxTrace2, name="Trace2"),
#               scatter(x = xPointsForPlot, y=PoxTrace3, name="Trace3")],
#               Layout(yaxis_range=(0,1)))
#
#     display(p)
#
#     # for cnt=1:2
#     #     sleep(0.5)
#     #     restyle!(p, y=values[:,1], values[:,2])
#     # end
#
# #end
#
# #plotConcProfile()
