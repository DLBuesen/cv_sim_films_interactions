using JLD


function expSimOverlayPlot()

        # Load the experimental data from the JLD file

        Exp_Potential_mV = load("temp/expPotentialAndCurrent.jld", "Exp_Potential_mV") ;
        Exp_TotalCurrent_uA = load("temp/expPotentialAndCurrent.jld", "Exp_TotalCurrent_uA") ;

        # Load the simulation data from the JLD file

        Potential_mV = load("temp/plotData.jld", "Potential_mV") ;
        TotalCurrent_uA = load("temp/plotData.jld", "TotalCurrent_uA") ;

        # Construct the Plot

        expTotalCurrent_uA = scatter(; x = Exp_Potential_mV, y = Exp_TotalCurrent_uA, mode="lines", name="Exp", marker_color = "rgb(169,169,169)", line_width = "5")

        simTotalCurrent_uA = scatter(; x = Potential_mV, y = TotalCurrent_uA, mode="lines", name ="Sim", line_dash = "dash", line_color = "rgb(0,72,186)", line_width = "3")

        data = [expTotalCurrent_uA,simTotalCurrent_uA] ;

        layout = Layout(;title="CV Overlay <br> Dimensional",
        xaxis_range=[1.1*minimum(Potential_mV), 1.1*maximum(Potential_mV)],
        xaxis=attr(title="(E-E0) [=] mV"),
        yaxis=attr(title="Current [=] uA")
        )

        dimensional_ExpSim_CV_Overlay_Plot = plot(data,layout)

        # Commands to get the window size and position after manually adjusting. After the optimal settings are determined, they can be set in the script before the window is created.

            # Blink.AtomShell.size(dimensional_ExpSim_CV_Overlay_Plot_Window)
            # Blink.AtomShell.position(dimensional_ExpSim_CV_Overlay_Plot_Window)

        global dimensional_ExpSim_CV_Overlay_Plot_Window = Blink.AtomShell.Window(
        Blink.shell(),
        Dict(  :width=>695,
                :height=>510,
                :alwaysOnTop=>false,
                :title=>"CV Exp and Sim Overlay Plot",
                :resizable=>true,
                :x=>578,
                :y=>251
                );
        async=false)

        Blink.body!(dimensional_ExpSim_CV_Overlay_Plot_Window,dimensional_ExpSim_CV_Overlay_Plot; fade=false, async=false)

        sleep(2) # To allow for the plot to completely appear before it is overlaid with another plot
end
