
println("Loading and compiling necessary packages...\n")

using JLD
println("Package 1 of 6 (JLD) loaded and compiled\n")
sleep(1)

using XLSX
println("Package 2 of 6 (XLSX) loaded and compiled\n")
sleep(1)

using Blink
println("Package 3 of 6 (Blink) loaded and compiled\n")
sleep(1)

using PlotlyJS
println("Package 4 of 6 (PlotlyJS) loaded and compiled\n")
sleep(1)

using DiffEqBase
println("Package 5 of 6 (DiffEqBase) loaded and compiled\n")
sleep(1)

using ORCA
println("Package 6 of 6 (ORCA) loaded and compiled\n")

println("Packages are loaded and compiled\n")
sleep(1)


println("Main menu is now loading...\n")
println("Wait until the menu is loaded before making any selections.\n")
sleep(1)

include("juliaFunctions/createWindow.jl")

# Set the name of the window

    windowName = "mainWindow"

# Load the HTML/CSS code for the main page

    indexHTML = open("UI/$windowName/index.html") do file
              read(file,String)
            end

    resetCSS = open("UI/$windowName/reset.css") do file
        read(file,String)
    end

    baseCSS = open("UI/$windowName/base.css") do file
        read(file,String)
    end

    styleCSS = open("UI/$windowName/style.css") do file
        read(file,String)
    end

    gridCSS = open("UI/$windowName/grid.css") do file
        read(file,String)
    end

    javaScript = open("UI/$windowName/javaScript.js") do file
        read(file,String)
    end

    HTML_CSS_JS_combined = indexHTML * "<style>" * resetCSS * baseCSS * styleCSS * gridCSS * "</style>" * "<script>" * javaScript * "</script>"

# Create Blink window and load HTML.

        global mainWindow = Blink.AtomShell.Window(
             Blink.shell(),
             Dict(  :width=>375,
                    :height=>499,
                    :alwaysOnTop=>true,
                    :title=>"Main Window",
                    :resizable=>true,
                    :x=>1467,
                    :y=>434
                    );
              async=false)

        # Blink.AtomShell.size(mainWindow)
        # Blink.AtomShell.position(mainWindow)

# Full list of electron windwo options
# https://electronjs.org/docs/api/browser-window#new-browserwindowoptions


        # global mainWindow = Blink.AtomShell.Window(
        #      Blink.shell(),
        #      Dict(  :width=>width,
        #             :height=>height
        #             :alwaysOnTop=>true
        #             );
        #       async=false)

        Blink.body!(mainWindow,HTML_CSS_JS_combined; fade=false, async=false)
        #sleep(5)

        #println("Main window is ready")

        # mainWindow = createWindow(windowName,width,height)
        # Blink.AtomShell.title(mainWindow,"Main Menu")

        display("The main window is now loaded.")
        #display("After pressing the 'Set File Path' Button, it will take at approximately 10 seconds for the next message to appear...")

        #@js_ mainWindow console.log("Hellow main window!")

    # Callback Functions

        # Set file paths button

        Blink.@js mainWindow filePathButton.onclick = function ()
                                                          console.log("filePathButton Pushed")
                                                          Blink.msg("filePathButtonCallback", "dummyVariable")
                                                        end

        include("UI/filePathSetWindow/main.jl")

        Blink.handlers(mainWindow)["filePathButtonCallback"] = function (n)
                                                          # println("filePathButtonCallback Function Reached!")
                                                          println("Opening file path selection window...")
                                                          openFilePathSetWindow()
                                                        end

        # Run simulation button

        Blink.@js mainWindow runSimButton.onclick = function ()
                                                          console.log("runSimButton Pushed")
                                                          Blink.msg("runSimButton_Blink", "dummyVariable")
                                                        end

        include("juliaFunctions/loadExpData.jl")
        include("juliaFunctions/loadParamsAndConvertUnits.jl")
        include("juliaFunctions/loadOptions.jl")
        include("juliaFunctions/solving/CV_FwdSweepReduction.jl")
        include("juliaFunctions/concProfileAnimation.jl")
        include("juliaFunctions/plotting/expSimOverlayPlot.jl")
        include("juliaFunctions/plotting/dimensionalCompositeSimulatedCV.jl")
        include("juliaFunctions/plotting/dimensionlessCompositeSimulatedCV.jl")
        include("juliaFunctions/plotting/compositeCVPanelFigure.jl")

        Blink.handlers(mainWindow)["runSimButton_Blink"] = function (n)
                                                          # println("runSimButton_Blink Handler Reached")
                                                          loadExpData()
                                                          loadParamsAndConvertUnits()
                                                          gridPlotOption,animationOption,expSimOverlayPlotOption,compositeCVoption = loadOptions()
                                                          CV_FwdSweepReduction()

                                                          if (expSimOverlayPlotOption=="Yes")
                                                              println("Making experimental and simulation overlay plot")
                                                              expSimOverlayPlot()
                                                          else
                                                              println("not making experimental and simulation overlay plot")
                                                          end

                                                          if (compositeCVoption=="Yes")
                                                              println("Making composite CV (capacitive and Faradaic current) panel figure")
                                                              dimensionalCompositeSimulatedCV_Plot = dimensionalCompositeSimulatedCV()
                                                              dimensionlessCompositeSimulatedCV_Plot = dimensionlessCompositeSimulatedCV()
                                                              compositeCVPanelFigure(dimensionalCompositeSimulatedCV_Plot,dimensionlessCompositeSimulatedCV_Plot)
                                                          else
                                                              println("Not making composite CV (capacitive and Faradaic current) panel figure")
                                                          end

                                                            if (animationOption=="Yes")
                                                                println("Making concentration profile animation")
                                                                concProfileAnimation()
                                                            else
                                                                println("Not making concentration profile animation")
                                                            end


                                                        end

        # To close the app

        Blink.@js mainWindow document.getElementById("closeAppButton").onclick = function ()
                    console.log("closeAppButton Pushed!")
            Blink.msg("closeAppEvent", "noVariable");

        end


        Blink.handlers(mainWindow)["closeAppEvent"] = function (n)
                    println("closeAppButton Callback Function Reached")

                    println("Deleting the temp folder")
                    println(isdir(pwd()*"/temp"))
                    if (isdir(pwd()*"/temp"))
                        println("Temp folder exists")
                        stat(pwd()*"/temp")
                        rm(pwd()*"/temp",recursive=true)
                    else
                        println("No temp folder was created")
                    end

                    println("Closing the app")
                    close(mainWindow)
                    exit() # Exit Julia
        end
