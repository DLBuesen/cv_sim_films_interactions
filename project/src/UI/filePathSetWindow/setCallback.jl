using JLD

function setCallback(n)

    # Open a new jld file (if not already there) and save the entry as "expDataParamsFileName"

    # Prepare the subfolder to contain the temporary data

    tempSubFolder = "temp" ;

    if isdir("$tempSubFolder")==false
      mkdir("$tempSubFolder")
      display("Creating temp folder!")
    else isdir("$tempSubFolder")==true
      display("temp folder already exists!")
    end

    save("temp/expDataParamsFileName.jld", "expDataParamsFileName", n)

    display("Parameter name file path is loaded!")
    display("Parameter name file path is $n")

end
