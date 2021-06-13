using XLSX
using JLD

function loadParamsAndConvertUnits()

    display("Starting to load parameters and convert units")

    # Get experimental data file name

    if isfile("temp/paramsFilePath.jld")
        paramsFilePath = load("temp/paramsFilePath.jld", "paramsFilePath")
    else
        println("Parameter file not yet selected")
    end

#-------
    # Constant

    FarConst_uA = 96485*(1.0e6) ;
          # [=] uA*s*mol-1, Faraday's constant

#-----

    Ptot_mM = XLSX.readdata(paramsFilePath, "ExptlParams", "B2") ;
      Ptot_cm3 = Ptot_mM*(1e-3)*(1e-3) ; # %Conversion to M then to mol*cm-3

    Dp_cm2_s = XLSX.readdata(paramsFilePath, "ExptlParams", "B3") ;

    k0_cm = XLSX.readdata(paramsFilePath, "ExptlParams", "B4") ;

    Alpha = XLSX.readdata(paramsFilePath, "ExptlParams", "B5") ;

#-----

    Ei_mV = XLSX.readdata(paramsFilePath, "ExptlParams", "B7") ;

    Es_mV = XLSX.readdata(paramsFilePath, "ExptlParams", "B8") ;

    Ef_mV = XLSX.readdata(paramsFilePath, "ExptlParams", "B9") ;

    Ep0_mV = XLSX.readdata(paramsFilePath, "ExptlParams", "B10") ;

    scanRate_mVps = XLSX.readdata(paramsFilePath, "ExptlParams", "B11") ;

#-----

    filmThickness_um = XLSX.readdata(paramsFilePath, "ExptlParams", "B13") ;
        filmThickness_cm = filmThickness_um*(1e-6)*(1e2) ;

    discArea_cm2 = XLSX.readdata(paramsFilePath, "ExptlParams", "B14") ;

    Temp_C = XLSX.readdata(paramsFilePath, "ExptlParams", "B15") ;
          Temp_K = Temp_C + 273.15 ; # Temperature in Kelvin

    # Solution resistance

    Rs_GOhm = XLSX.readdata(paramsFilePath, "ExptlParams", "B17") ;
        Rs_Ohm = (1e9)*Rs_GOhm ; # [=] Ohm, Ohm = V*A^-1

    # Double layer capacitance

    Cd_pF = XLSX.readdata(paramsFilePath, "ExptlParams", "B18") ;
        Cd_F = Cd_pF*(1e-12) ; # [=] Farads, F = A*s*V^-1
        Cd_uA_mV = Cd_pF ; # [=] uA*s-1*mV-1

    # Interaction parameter

    gBard = XLSX.readdata("$paramsFilePath", "ExptlParams", "B20") ;


 # Save the initial plot variables in a jld file for later use

          jldopen("temp/exptlParams.jld", "w") do file
              write(file, "FarConst_uA", FarConst_uA)
              write(file, "Ptot_cm3", Ptot_cm3)
              write(file, "Dp_cm2_s", Dp_cm2_s)
              write(file, "k0_cm", k0_cm)
              write(file, "Alpha", Alpha)
              write(file, "Ei_mV", Ei_mV)
              write(file, "Es_mV", Es_mV)
              write(file, "Ef_mV", Ef_mV)
              write(file, "Ep0_mV", Ep0_mV)
              write(file, "scanRate_mVps", scanRate_mVps)
              write(file, "filmThickness_cm", filmThickness_cm)
              write(file, "discArea_cm2", discArea_cm2)
              write(file, "Temp_K", Temp_K)
              write(file, "Rs_Ohm", Rs_Ohm)
              write(file, "Cd_F", Cd_F)
              write(file, "Cd_uA_mV", Cd_uA_mV)
              write(file, "gBard", gBard)
          end

          # To view all of the variables in a jld file
          # In the REPL
          # using JLD
          # d = load("temp/exptlParams.jld")

       display("Parameters loaded and units converted")

end
