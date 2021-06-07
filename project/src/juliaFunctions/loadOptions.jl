using JLD
using XLSX

function loadOptions()

display("Loading options")

# Get experimental data file name

if isfile("temp/paramsFilePath.jld")
    paramsFilePath = load("temp/paramsFilePath.jld", "paramsFilePath")
else
    println("Parameter file not yet selected")
end


# expDataParamsFileName = load("temp/expDataParamsFileName.jld", "expDataParamsFileName")

# Reading the plots options

gridPlotOption = XLSX.readdata(paramsFilePath, "Options", "B4") ;

animationOption = XLSX.readdata(paramsFilePath, "Options", "B6") ;

expSimOverlayPlotOption = XLSX.readdata(paramsFilePath, "Options", "B8") ;

compositeCVoption = XLSX.readdata(paramsFilePath, "Options", "B10") ;

# Solver options

numIntervals = XLSX.readdata(paramsFilePath, "Options", "E4") ;

Beta = XLSX.readdata(paramsFilePath, "Options", "E6") ;

abstol = XLSX.readdata(paramsFilePath, "Options", "E8") ;

reltol = XLSX.readdata(paramsFilePath, "Options", "E10") ;

saveat = XLSX.readdata(paramsFilePath, "Options", "E12") ;

# Save the options in a jld file

    jldopen("temp/options.jld", "w") do file
        write(file, "gridPlotOption", gridPlotOption)
        write(file, "animationOption", animationOption)
        write(file, "expSimOverlayPlotOption", expSimOverlayPlotOption)
        write(file, "numIntervals", numIntervals)
        write(file, "Beta", Beta)
        write(file, "abstol", abstol)
        write(file, "reltol", reltol)
        write(file, "saveat", saveat)
    end

    return gridPlotOption,animationOption,expSimOverlayPlotOption,compositeCVoption,numIntervals,Beta,abstol,reltol,saveat

    # To view all of the variables in a jld file
    # In the REPL
    # using JLD
    # d = load("temp/options.jld")

end
