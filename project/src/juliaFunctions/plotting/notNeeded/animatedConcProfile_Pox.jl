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

# Initiating the window

timeIndex = 1 ;
dimensionlessTime = sol.t[timeIndex] ;
Pox = sol[1,PoxSpaceIndexStart:PoxSpaceIndexEnd,timeIndex] ;
    # Results in an array
    # Pox = transpose(Pox) ; # To convert to a row matrix
Pred = 1.0 .- Pox ;
# println("Pox at time index $timeIndex of $numTimePts total and dimensionless time $dimensionlessTime = $Pox")
# println("")

# Create the folder for the png plot if it isn't yet there

# Prepare the subfolder to contain the temporary data

tempSubFolder = "PoxPlotAnimationTempFrames" ;

if isdir("$tempSubFolder")==false
  mkdir("$tempSubFolder")
  display("Creating $tempSubFolder folder")
else isdir("$tempSubFolder")==true
  display("$tempSubFolder folder already exists")
end


# Plot in plotlyJS

Pox_trace = scatter(; y = Pox, mode="lines", name="Pox", line_color = "rgb(52/235, 52/235, 235/235)", line_width = "3")

Pred_trace = scatter(; y = Pred, mode="lines", name="Pred", line_dash = "dash", line_color = "rgb(52/235, 52/235, 235/235)", line_width = "3")

data = [Pox_trace,Pred_trace] ;

layout = Layout(;title="Pox and Pred Dimensionless Concentration Profile <br> TimeIndex = $timeIndex of $numTimePts ",
xaxis=attr(title="Dimensionless Distance"),
yaxis=attr(title="Dimensionless Concentration")
)

# Plots in Atom Plots pane as well, but needed for plotting in PlotlyJS Electron window
dimensionlessConcProfileOverlay_PoxPred_Plot = plot(data,layout)


global dimensionlessConcProfileOverlay_PoxPred_Plot_Window = Blink.AtomShell.Window(
Blink.shell(),
Dict(  :width=>695,
      :height=>510,
      :alwaysOnTop=>false,
      :title=>"Capturing Frames For Animation...",
      :resizable=>true,
      :x=>731,
      :y=>250
      );
async=false)

Blink.body!(dimensionlessConcProfileOverlay_PoxPred_Plot_Window, dimensionlessConcProfileOverlay_PoxPred_Plot; fade=false, async=false)

savefig(dimensionlessConcProfileOverlay_PoxPred_Plot,"$tempSubFolder/frame$timeIndex.png")

#------------------------------------------------------------------------
# # Update the plot once
#
# timeIndex = 2 ;
# dimensionlessTime = sol.t[timeIndex] ;
# Pox = sol[1,PoxSpaceIndexStart:PoxSpaceIndexEnd,timeIndex] ;
#     # Results in an array
#     # Pox = transpose(Pox) ; # To convert to a row matrix
# Pred = 1.0 .- Pox ;
#
# sleep(2)
#
# # Update the title with the new time index and time value
#
# relayout!(dimensionlessConcProfileOverlay_PoxPred_Plot, title="Pox and Pred Dimensionless Concentration Profile <br> TimeIndex = $timeIndex of $numTimePts ")
#
# # Update the concentration profile traces
#
# traceNumberToUpdate = 1 ;
# restyle!(dimensionlessConcProfileOverlay_PoxPred_Plot, [traceNumberToUpdate], y = [Pox])
#
# traceNumberToUpdate = 2 ;
# restyle!(dimensionlessConcProfileOverlay_PoxPred_Plot, [traceNumberToUpdate], y = [Pred])
#
# # Update the Electron window
#
# Blink.body!(dimensionlessConcProfileOverlay_PoxPred_Plot_Window, dimensionlessConcProfileOverlay_PoxPred_Plot; fade=false, async=false)

# Update the plot in a for loop

for i=2:numTimePts

      timeIndex_updated = i ;
      dimensionlessTime_updated = sol.t[timeIndex_updated] ;
      Pox_updated = sol[1,PoxSpaceIndexStart:PoxSpaceIndexEnd,timeIndex_updated] ;
          # Results in an array
          # Pox = transpose(Pox) ; # To convert to a row matrix
      Pred_updated = 1.0 .- Pox_updated ;

      sleep(0.1)

      # Update the title with the new time index and time value

      relayout!(dimensionlessConcProfileOverlay_PoxPred_Plot, title="Pox and Pred Dimensionless Concentration Profile <br> TimeIndex = $timeIndex_updated of $numTimePts ")

      # Update the concentration profile traces

      traceNumberToUpdate = 1 ;
      restyle!(dimensionlessConcProfileOverlay_PoxPred_Plot, [traceNumberToUpdate], y = [Pox_updated])

      traceNumberToUpdate = 2 ;
      restyle!(dimensionlessConcProfileOverlay_PoxPred_Plot, [traceNumberToUpdate], y = [Pred_updated])

      # Update the Electron window

      Blink.body!(dimensionlessConcProfileOverlay_PoxPred_Plot_Window, dimensionlessConcProfileOverlay_PoxPred_Plot; fade=false, async=false)

      # Save the frame

      savefig(dimensionlessConcProfileOverlay_PoxPred_Plot,"$tempSubFolder/frame$timeIndex_updated.png")

  end

# Convert the files to a mp4 movie

run(`ffmpeg -i $tempSubFolder/frame%d.png ../../temp/PoxConcProfileAnimation.mp4`)

# Delete the frame files

run(`rm -R $tempSubFolder`)

# Close the concentration profile electron window

close(dimensionlessConcProfileOverlay_PoxPred_Plot_Window)

# Open the mp4 movie from the command line

run(`vlc -q ../../temp/PoxConcProfileAnimation.mp4`)
