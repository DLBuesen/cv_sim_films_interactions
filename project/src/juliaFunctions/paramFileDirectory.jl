using JLD

function paramFileDirectory()
#function paramFileDirectory(paramsFileName,paramsFilePath)


   # Extracts the directory of the parameter file directory based on the extracted name and full path

    # Load the file name and path

    paramsFileName = load("temp/paramsFileName.jld", "paramsFileName") ;
    paramsFilePath = load("temp/paramsFilePath.jld", "paramsFilePath") ;

    # Obtain the number of string characters in the file name

    paramsFileNameLength = sizeof(paramsFileName) ;
    paramsFilePathLength = sizeof(paramsFilePath) ;

    # Subtracting the file name from the path name to get the directory
    # Remove the specified number of characters from the full path to get the directory

    paramsFileNameDirectory_LastCharacter = paramsFilePathLength - paramsFileNameLength ;

    paramsFileNameDirectory = paramsFilePath[1:paramsFileNameDirectory_LastCharacter] ;

    save("temp/paramsFileDirectory.jld", "paramsFileNameDirectory", paramsFileNameDirectory)
    display("Parameter file directory is $paramsFileNameDirectory")

    # return paramsFileNameDirectory


end