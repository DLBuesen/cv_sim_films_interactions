using JLD

function saveExcelParamFilePath(varsFromJS)

  # Separating the individual variables after the Javascript callback function (only one variable can be passed, so it must firstly be combined in an array)

  paramsFileName = varsFromJS[1]
  println("Params File Name = $paramsFileName")

  paramsFilePath = varsFromJS[2]
  println("Params File Path = $paramsFilePath")

  # Prepare the subfolder to contain the temporary data if it isn't already there

    tempSubFolder = "temp" ;

    if isdir("$tempSubFolder")==false
      mkdir("$tempSubFolder")
      display("Creating temp folder!")
    else isdir("$tempSubFolder")==true
      display("temp folder already exists!")
    end

  # Save each parameter in a separate jld file

    save("temp/paramsFileName.jld", "paramsFileName", paramsFileName)
    save("temp/paramsFilePath.jld", "paramsFilePath", paramsFilePath)

        # data = load("temp/paramsFileName.jld")
        # data = load("temp/paramsFilePath.jld")

  # Display confimation messages to the screen

    display("Parameter file path is loaded")
    display("Parameter file name is $paramsFileName")
    display("Parameter file path is $paramsFilePath")

end
