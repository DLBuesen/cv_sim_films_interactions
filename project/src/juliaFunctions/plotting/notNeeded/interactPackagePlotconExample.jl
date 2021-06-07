using Interact
using PlotlyJS
using Blink

xData = range(-4, 4, length = 70)
    # Equivalent to linspace(-4, 4, 70) in Matlab

yData = sin.(xData)

#p = plot(x,y)

trace_1 = scatter(x = xData; y = yData, mode="lines", line_dash = "dashdot", name="Pox", line_color = "rgb(204, 170, 0)", line_width = "3")

layout = Layout(;title="Interact Example ",
xaxis=attr(title="x Axis"),
yaxis=attr(title="y Axis")
)

data = [trace_1]

# Plots in Atom Plots pane as well, but needed for plotting in PlotlyJS
testData_Plot = plot(data,layout)
display(testData_Plot)

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

Blink.body!(dimensionlessConcProfileOverlay_Plot_Window,testData_Plot; fade=false, async=false)

colors = ["red", "green", "blue", "orange"]

@manipulate for c in colors
      restyle!(testData_Plot, [1], line_color=c)
      Blink.body!(dimensionlessConcProfileOverlay_Plot_Window,testData_Plot; fade=false, async=false)
end
