using XLSX
using JLD
using PlotlyJS

expDataParamsFileName = open("temp/expDataParamsFileName.txt") do file
          read(file,String)
        end

# Load the entire contents of scan rates in column A (skipping empty entries), determine the number of scan-rates, and then use the number of scan rates to set the correct range to read the data from the column (want the scan rates only and not the label)
v_Exp_Vps = XLSX.readdata(expDataParamsFileName, "ExptlData", "A") ;

          arraySize = size(v_Exp_Vps) ;
          numScanRates = arraySize[1] - 1 ;

          startRowIndex = 2 ;
          endRowIndex = numScanRates + 1 ;

          v_Exp_Vps = XLSX.readdata(expDataParamsFileName, "ExptlData", "A$startRowIndex:A$endRowIndex") ;
          v_Exp_Vps = vec(v_Exp_Vps).*1.0 ;
                  # vec to onvert to a one-dimensional column vector
                  # Multiply by 1.0 to convert it to a Float64 type
          v_Exp_mVps = v_Exp_Vps.*(1e3) ;
                # Convert the units

Ip_Exp_A = XLSX.readdata(expDataParamsFileName, "ExptlData", "B");

        # Already know the number of scan rates
        startRowIndex = 2 ;
        endRowIndex = numScanRates + 1 ;
        Ip_Exp_A = XLSX.readdata(expDataParamsFileName, "ExptlData", "B$startRowIndex:B$endRowIndex") ;
        Ip_Exp_A = vec(Ip_Exp_A).*1.0 ;
              # vec to onvert to a one-dimensional column vector
              # Multiply by 1.0 to convert it to a Float64 type
          Ip_Exp_uA = Ip_Exp_A.*(1e6) ;

 # Process the data for the initial plot
          vHalf_Exp_mVps = (v_Exp_mVps).^0.5 ;
          IpDivVHalf_Exp_uA_mVps = Ip_Exp_uA./vHalf_Exp_mVps ;


 # Save the initial plot variables in a jld file for later use

          jldopen("temp/initPlotData.jld", "w") do file
              write(file, "v_Exp_mVps", v_Exp_mVps)
              write(file, "Ip_Exp_uA", Ip_Exp_uA)
              write(file, "vHalf_Exp_mVps", vHalf_Exp_mVps)
              write(file, "IpDivVHalf_Exp_uA_mVps", IpDivVHalf_Exp_uA_mVps)
              write(file, "numScanRates", numScanRates)
          end


# For an interactive plot in a separate UI window using PlotlyJS

              plot(
                  scatter(
                          x = v_Exp_mVps,
                          y = Ip_Exp_uA,
                          # marker_symbol = "square",
                          marker_symbol = "circle",
                          marker_color = "blue",
                          marker_size = 10.0,
                          marker_line_color = "black",
                          marker_line_width = 2.0,
                          # mode markers takes away the line to make it only a scatter plot
                          mode = "markers"
                          ),
                  Layout(
                         title = "Initial Plot",
                         xaxis_title_text = "v [=] mV",
                         # xaxis_range = [0,1000],
                         yaxis_title_text = "Ip [=] uA",
                         # yaxis_range = [0,300],
                         )
                                         )


# # For a static, non-interactive plot in the Atom Plots view

# using Plots
# plotlyjs()
# scatter(v_Exp_mVps,Ip_Exp_uA)
# title!("Initial Plot")
# xlabel!("v [=] mV")
# ylabel!("Ip [=] uA")
