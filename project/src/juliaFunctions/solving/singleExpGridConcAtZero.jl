using JLD
using PlotlyJS
using Blink


function singleExpGridConcAtZero(numIntervals,Beta)

        gridPlotOption = load("temp/options.jld","gridPlotOption") ;

        # Creating exponentially increasing grids with points concentrated at 0 or at 1, where the points are changing exponentially according to the function y = e^-βx.

        # Start by defining the number of intervals (numIntervals) and the exponential factor (Beta)

        # The total number of points is determined from the number of intervals

        numPts = numIntervals + 1 ;

        # Start with a linearly spaced set of points

        NumSet1 = range(0,1,length=numPts)

        # Calculate the corresponding set of y values using the exponential function

        y1 = exp.(-Beta.*NumSet1)

        # This results in a plot where the y values start from 1 but would likely not decay to zero at x=1 (there will be an offset), so need to subtract from the y values such that the y value will be zero when x=1.

        offset1 = y1[end]

        y2 = y1 .- offset1 ;

        # Next, need to scale the y axis to be between 0 and 1 by dividing by the first (maximum) y value.

        y3 = y2 ./ y2[1] ;

        # This results in a set of points that are more densely concentrated near x = 0 and becomes exponentially less densely concentrated as x goes to 1. But the array starts with values at 1 and decreases instead of the opposite. So, need to sort the numbers in ascending order.

        # Sort the values in ascending order

        xExpGrid0 = sort(y3) ;

        # Can now calculate the spacing between the points

        # Memory pre-allocation

        h0 = zeros(1,numIntervals)

        for i = 1:numIntervals
            h0[i] = xExpGrid0[i+1] - xExpGrid0[i]
        end

        # Optionally, can print out the grids, which can be helpful to see how Beta is effecting the grid.

        # All of the y points are actually equal to zero in the grid, so need to change the y values to zero

        yForGrid = y3.*0.0 ;

        if(gridPlotOption=="Yes")

                display("Grids will be plotted. Change 'PlotGridsOption' to 'NoPlots' to generate the grid without plots.")

                #Plot the exponential grid with points concen        # Only was abke to return the variables when they were all column vectorstrated at x=0
                    dataSet1 = scatter(; x = xExpGrid0, y = yForGrid, mode="markers", marker_size="5")

                    data = [dataSet1] ;

                    layout = Layout(;title="Exponential Grid",
                    xaxis_range=[-0.001, 1.001],
                    yaxis_range=[-0.001, 0.001]
                    )

                    exponentialGridPlot = plot(data,layout)

                    # Commands to get the window size and position after manually adjusting. After the optimal settings are determined, they can be set in the script before the window is created.

                    # Blink.AtomShell.size(exponentialGridPlotWindow)
                    # Blink.AtomShell.position(exponentialGridPlotWindow)

                    global exponentialGridPlotWindow = Blink.AtomShell.Window(
                         Blink.shell(),
                         Dict(  :width=>695,
                                :height=>510,
                                :alwaysOnTop=>false,
                                :title=>"Exponential Grid With Beta=$Beta",
                                :resizable=>true,
                                :x=>578,
                                :y=>251
                                );
                          async=false)

                    Blink.body!(exponentialGridPlotWindow,exponentialGridPlot; fade=false, async=false)

                    sleep(2) # To allow for the plot to completely appear before it is overlaid with another plot

        elseif(gridPlotOption=="No")
                display("Grids are not plotted. Change 'Grid plotting option' to 'Yes' to generate the plots along with the grids.")
        end


        jldopen("temp/singleExpGridConcAtZero.jld", "w") do file
            write(file, "xExpGrid0", xExpGrid0)
            write(file, "h0", h0)
            write(file, "numPts", numPts)
        end

        # xExpGrid0 = load("temp/singleExpGridConcAtZero.jld", "xExpGrid0")
        # Data = load("temp/singleExpGridConcAtZero.jld")

        return xExpGrid0,h0,numPts

end
