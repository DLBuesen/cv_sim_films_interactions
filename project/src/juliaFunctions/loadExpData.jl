using XLSX
using JLD
using PlotlyJS

function loadExpData()


        if isfile("temp/paramsFilePath.jld")
                paramsFilePath = load("temp/paramsFilePath.jld", "paramsFilePath")
        else
                println("Parameter file not yet selected")
        end

        # Load the entire contents of scan rates in column A (skipping empty entries), determine the number of scan-rates, and then use the number of scan rates to set the correct range to read the data from the column (want the scan rates only and not the label)

        # Load the entire contents of potential values

        Exp_Potential_mV = XLSX.readdata(paramsFilePath, "ExptlCVData", "A") ;

                  arraySize = size(Exp_Potential_mV) ;
                  numPotentialPts = arraySize[1] - 1 ;

                  startRowIndex = 2 ;
                  endRowIndex = numPotentialPts + 1 ;

                  Exp_Potential_mV = XLSX.readdata(paramsFilePath, "ExptlCVData", "A$startRowIndex:A$endRowIndex") ;
                  Exp_Potential_mV = vec(Exp_Potential_mV).*1.0 ;
                          # vec to onvert to a one-dimensional column vector
                          # Multiply by 1.0 to convert it to a Float64 type

        # Load the entire contents of potential values

        Exp_TotalCurrent_uA = XLSX.readdata(paramsFilePath, "ExptlCVData", "B") ;

                arraySize = size(Exp_TotalCurrent_uA) ;
                numExpCurrentPts = arraySize[1] - 1 ;

                startRowIndex = 2 ;
                endRowIndex = numExpCurrentPts + 1 ;

                Exp_TotalCurrent_uA = XLSX.readdata(paramsFilePath, "ExptlCVData", "B$startRowIndex:B$endRowIndex") ;
                Exp_TotalCurrent_uA = vec(Exp_TotalCurrent_uA).*1.0 ;
                        # vec to onvert to a one-dimensional column vector
                        # Multiply by 1.0 to convert it to a Float64 type

        # Save the data for later use

        save("temp/expPotentialAndCurrent.jld", "Exp_Potential_mV", Exp_Potential_mV, "Exp_TotalCurrent_uA", Exp_TotalCurrent_uA)

        # Making a plot to check the function

                #   expTotalCurrent_uA = scatter(; x = Exp_Potential_mV, y = Exp_TotalCurrent_uA, mode="lines", name="Exp", marker_color = "rgb(169,169,169)", line_width = "5")
                #
                #   data = [expTotalCurrent_uA];
                #
                #   layout = Layout(;title="CV Initial Plot <br> Dimensional",
                #   xaxis_range=[1.1*minimum(Exp_Potential_mV), 1.1*maximum(Exp_Potential_mV)],
                #   xaxis=attr(title="Potential [=] mV"),
                #   yaxis=attr(title="Current [=] uA")
                #   )
                #
                #   initialCVPlot = plot(data,layout)
                #
                #   global initialCVPlotWindow = Blink.AtomShell.Window(
                #        Blink.shell(),
                #        Dict(  :width=>695,
                #               :height=>510,
                #               :alwaysOnTop=>false,
                #               :title=>"Initial CV Plot",
                #               :resizable=>true,
                #               :x=>731,
                #               :y=>250
                #               );
                #         async=false)
                #
                # # Blink.AtomShell.size(initialCVPlotWindow)
                # # Blink.AtomShell.position(initialCVPlotWindow)
                #
                # Blink.body!(initialCVPlotWindow,initialCVPlot; fade=false, async=false)


end
