
function openFilePathSetWindow()

    # println("Loading file path select window...")

    # Set the name of the window

        windowName = "filePathSetWindow"

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

            global filePathSetWindow = Blink.AtomShell.Window(
                 Blink.shell(),
                 Dict(  :width=>371,
                        :height=>214,
                        :alwaysOnTop=>false,
                        :title=>"Select File",
                        :resizable=>true,
                        :x=>1465,
                        :y=>160
                        );
                  async=false)

            # Blink.AtomShell.size(filePathSetWindow)
            # Blink.AtomShell.position(filePathSetWindow)

            Blink.body!(filePathSetWindow,HTML_CSS_JS_combined; fade=false, async=false)
                  #sleep(5)

    Blink.@js filePathSetWindow console.log("Hello filePathSetWindow!")

    display("File path selection window is now ready")


    Blink.@js filePathSetWindow browseButton.onchange = function ()
        console.log("Browse button was clicked")
        paramsFileName = document.getElementById("browseButton").files[0].name ;
        paramsFilePath = document.getElementById("browseButton").files[0].path ;
        # console.log("Params File Name = " + paramsFileName) ;
        # console.log("Params File Path = " + paramsFilePath) ;
        varsFromJS = [paramsFileName,paramsFilePath] ;
        Blink.msg("browseButtonClicked", varsFromJS)
      end

include("juliaFunctions/saveExcelParamFilePath.jl")
        # has to be before the function definition or else it won't load
include("juliaFunctions/paramFileDirectory.jl")


    Blink.handlers(filePathSetWindow)["browseButtonClicked"] = function (varsFromJS)
        # println("Browse button was clicked")
        # println("Message from Julia Side")
        # println("varsFromJS = $varsFromJS")
        saveExcelParamFilePath(varsFromJS)
        paramFileDirectory()
    end


    display("File Path Set Window is loaded")
        # To allow for everyting to load

  end
