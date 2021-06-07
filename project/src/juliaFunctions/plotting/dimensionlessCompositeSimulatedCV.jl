using JLD

function dimensionlessCompositeSimulatedCV()

		# Load the simulation data from the JLD file

		epsilon_p = load("temp/plotData.jld", "epsilon_p") ;
		CapacitiveCurrent = load("temp/plotData.jld", "CapacitiveCurrent") ;
		FaradaicCurrent = load("temp/plotData.jld", "FaradaicCurrent") ;
		TotalCurrent = load("temp/plotData.jld", "TotalCurrent") ;

		# Construct the plot

  		capacitiveCurrent = scatter(; x = epsilon_p, y = CapacitiveCurrent, mode="lines", line_dash = "dashdot", name="Capacitive", line_color = "rgb(204, 170, 0)", line_width = "3") ;

  		faradaicCurrent = scatter(; x = epsilon_p, y = FaradaicCurrent, mode="lines", name="Faradaic", line_dash = "dash", line_color = "rgb(124, 10, 2)", line_width = "4") ;

  		totalCurrent = scatter(; x = epsilon_p, y = TotalCurrent, mode="lines", name ="Total", line_color = "rgb(169,169,169)", line_width = "5") ;

  		data = [capacitiveCurrent,faradaicCurrent,totalCurrent] ;

  		layout = Layout(;
  			title="Composite Simulated CV <br> Dimensionless",
  			xaxis_range=[1.1*minimum(epsilon_p), 1.1*maximum(epsilon_p)],
			xaxis_tickmode = "array",
			xaxis_tickvals = [-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
			yaxis_range=[1.1*minimum(TotalCurrent), 1.1*maximum(TotalCurrent)],
			yaxis_tickmode = "array",
			yaxis_tickvals = [-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1],
  			xaxis=attr(title="Dimensioness (E-E0)"),
  			yaxis=attr(title="Dimensionless Current"),
  			)

  		dimensionlessCompositeSimulatedCV_Plot = plot(data,layout)
  	# To plot in Atom plots pane

		# global dimensionlessCompositeSimulatedCV_Plot_Window = Blink.AtomShell.Window(
  	   	# Blink.shell(),
  	   	# Dict(  :width=>695,
  		# 	  :height=>510,
  		# 	  :alwaysOnTop=>false,
  		# 	  :title=>"Simulated Dimensionless Composite CV",
  		# 	  :resizable=>true,
  		# 	  :x=>731,
  		# 	  :y=>250
  		# 	  );
  		# async=false)
		#
		# Blink.body!(dimensionlessCompositeSimulatedCV_Plot_Window,dimensionlessCompositeSimulatedCV_Plot; fade=false, async=false)

		return dimensionlessCompositeSimulatedCV_Plot

end
