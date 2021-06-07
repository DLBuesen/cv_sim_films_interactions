function createWindow(windowName,width,height)


    # width = 850;
    # height = 850;

    # windowName = "main";

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

    window = Blink.AtomShell.Window()
    # Setting the individual option


    # window = Blink.AtomShell.Window(Blink.shell(), Dict(:width=>width,:height=>height); async=false)
    # window = Blink.Window()
    Blink.body!(window,HTML_CSS_JS_combined; fade=false)
    sleep(5)
    # Blink.tools(window)

    display("The GUI window is loaded")

    Blink.@js window console.log("The GUI window is loaded")

    return window

end
