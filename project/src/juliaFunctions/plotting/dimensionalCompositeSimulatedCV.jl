using JLD

function dimensionalCompositeSimulatedCV()

		# Load the simulation data from the JLD file

		Potential_mV = load("temp/plotData.jld", "Potential_mV") ;
		CapacitiveCurrent_uA = load("temp/plotData.jld", "CapacitiveCurrent_uA") ;
		FaradaicCurrent_uA = load("temp/plotData.jld", "FaradaicCurrent_uA") ;
		TotalCurrent_uA = load("temp/plotData.jld", "TotalCurrent_uA") ;

		# Construct the plot

	  	capacitiveCurrent = scatter(; x = Potential_mV, y = CapacitiveCurrent_uA, mode="lines", line_dash = "dashdot", name="Capacitive", line_color = "rgb(204, 170, 0)", line_width = "3")

	  	faradaicCurrent = scatter(; x = Potential_mV, y = FaradaicCurrent_uA, mode="lines", name="Faradaic", line_dash = "dash", line_color = "rgb(124, 10, 2)", line_width = "4")

	  	totalCurrent = scatter(; x = Potential_mV, y = TotalCurrent_uA, 	mode="lines", name ="Total", line_color = "rgb(169, 169, 169)", 		line_width = "5")

	  	data = [capacitiveCurrent,faradaicCurrent,totalCurrent] ;

	  	layout = Layout(;title="Composite Simulated CV <br> Dimensional",
	  	xaxis_range=[1.1*minimum(Potential_mV), 1.1*maximum(Potential_mV)],
	  	xaxis=attr(title="E [=] mV"),
	  	yaxis=attr(title="Current [=] uA")
	  	)

  # Plots in Atom Plots pane as well, but needed for plotting in PlotlyJS

  		dimensionalCompositeSimulatedCV_Plot = plot(data,layout)

		# dimensionalCompositeSimulatedCV_Plot = plot!(data,layout)
			# To allow for overlay

  		# global dimensionalCompositeSimulatedCV_Plot_Window = Blink.AtomShell.Window(
	   	# Blink.shell(),
	   	# Dict(  :width=>695,
		# 	  :height=>510,
		# 	  :alwaysOnTop=>false,
		# 	  :title=>"Simulated Dimensional Composite CV",
		# 	  :resizable=>true,
		# 	  :x=>731,
		# 	  :y=>250
		# 	  );
		# async=false)
		#
 		# Blink.body!(dimensionalCompositeSimulatedCV_Plot_Window,dimensionalCompositeSimulatedCV_Plot; fade=false, async=false)

		return dimensionalCompositeSimulatedCV_Plot

end
