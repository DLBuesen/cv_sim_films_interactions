using JLD

function calcDimensionlessGrps()

    exptlParamsFileNameAndPath = "temp/exptlParams.jld"

#-----
# Loading the dimensional parameters with converted units and some preliminary calculations

    # Dimensional parameters and unit conversions

    	scanRate_mVps = load("$exptlParamsFileNameAndPath", "scanRate_mVps")

    	FarConst_uA = load("$exptlParamsFileNameAndPath", "FarConst_uA")

    	Ptot_cm3 = load("$exptlParamsFileNameAndPath", "Ptot_cm3")
        Ytot_cm3 = load("$exptlParamsFileNameAndPath", "Ytot_cm3")

		k_py_cm3 = load("$exptlParamsFileNameAndPath", "k_py_cm3")

		Dp_cm2_s = load("$exptlParamsFileNameAndPath", "Dp_cm2_s")
		Dy_cm2_s = load("$exptlParamsFileNameAndPath", "Dy_cm2_s")

		discArea_cm2 = load("$exptlParamsFileNameAndPath", "discArea_cm2")

		filmThickness_cm = load("$exptlParamsFileNameAndPath", "filmThickness_cm")

		k0_cm = load("$exptlParamsFileNameAndPath", "k0_cm")
		Alpha = load("$exptlParamsFileNameAndPath", "Alpha")

		gBard = load("$exptlParamsFileNameAndPath", "gBard")

		Ei_mV = load("$exptlParamsFileNameAndPath", "Ei_mV")
		Es_mV = load("$exptlParamsFileNameAndPath", "Es_mV")
		Ef_mV = load("$exptlParamsFileNameAndPath", "Ef_mV")

		Ep0_mV = load("$exptlParamsFileNameAndPath", "Ep0_mV")

		Rs_Ohm = load("$exptlParamsFileNameAndPath", "Rs_Ohm")


		Cd_F = load("$exptlParamsFileNameAndPath", "Cd_F")
		Cd_uA_mV = load("$exptlParamsFileNameAndPath", "Cd_uA_mV")

	# Cell constant

		RsCd_s = Rs_Ohm*Cd_F ; # Cell constant [=] s

	# Max capacitive current

		maxCapCurrent_uA = scanRate_mVps*Cd_uA_mV ;

	# Temperature in Celsius and calculation of RT/nF

		Temp_K = load("$exptlParamsFileNameAndPath", "Temp_K")

	    	RdivF = 8314/96485 ; #  RdivF [=] K-1 mV
	    RTdivF_mV = RdivF * Temp_K ; # [=] mV

#-----
# Calculation of important reference quantities

	# Calculation of the reference current (Semi-Infinite)

			Part1 = 0.4463*FarConst_uA*discArea_cm2*Ptot_cm3*sqrt(Dp_cm2_s)*sqrt(scanRate_mVps) ;
			Part2 = sqrt(RTdivF_mV) ;

		refCurrent_uA = (Part1)/(Part2) ;

	# Quantities relevant for comparison to an adsorbed monolayer

		G_Laviron = -0.25*gBard ;

			Gamma_mol_cm2 = Ptot_cm3 * filmThickness_cm ;
		Gamma_pmol_cm2 = Gamma_mol_cm2*(1e12) ;

		refCurrent_AdsMono_uA = (1/4)*FarConst_uA*discArea_cm2*(scanRate_mVps/RTdivF_mV)*Gamma_mol_cm2 ;

		psiLaviron_uA = 4*refCurrent_AdsMono_uA ;

		peakPotentialLaviron_mV = Ep0_mV - (2 *RTdivF_mV * G_Laviron) ;


	# Xi400 for use in scaling the potential

		Xi400 = 400/RTdivF_mV ;

	# Calculation of the reference time

		refTime_s = (Xi400*RTdivF_mV)/scanRate_mVps ;

#-----

# Calculation of dimensionless groups, used for scaling the major variables (time, space, and concentrations) to be on the order of 1 before solving. After solving, the dimensionless results are converted to dimensional current and potential.

	   Part1 = filmThickness_cm*sqrt(scanRate_mVps) ;
	   Part2 = sqrt(Dp_cm2_s)*sqrt(RTdivF_mV) ;
	global wHalf_p = (Part1) / (Part2) ;

	   Part1 = filmThickness_cm*sqrt(scanRate_mVps) ;
	   Part2 = sqrt(Dy_cm2_s)*sqrt(RTdivF_mV) ;
	wHalf_y = (Part1) / (Part2) ;

	tauCap = 3*RsCd_s/refTime_s ;

	zetaCap = scanRate_mVps*Cd_uA_mV/refCurrent_uA ;

	phiP = k0_cm/(Dp_cm2_s/filmThickness_cm) ;

	Eref_mV = RTdivF_mV ;

	Epsilon_pi = (Ei_mV-Ep0_mV)/Eref_mV ;
	Epsilon_ps = (Es_mV-Ep0_mV)/Eref_mV ;
	Epsilon_pf = (Ef_mV-Ep0_mV)/Eref_mV ;

	   Part1 = (k_py_cm3)*(Ptot_cm3)*(Ytot_cm3) ;
	   Part2 = (Ptot_cm3)*(Dp_cm2_s/(filmThickness_cm^2)) ;
	kappa_py_p = Part1/Part2 ;

	   Part1 = (k_py_cm3)*(Ptot_cm3)*(Ytot_cm3) ;
	   Part2 = (Ytot_cm3)*(Dy_cm2_s/(filmThickness_cm^2)) ;
	kappa_py_y = Part1/Part2 ;

# Calculation of time related parameters

	t_tot = ( Eref_mV / (Xi400*RTdivF_mV) )*(Epsilon_pi-Epsilon_ps+Epsilon_pf-Epsilon_ps) ;
	t_fwd = ( Eref_mV / (Xi400*RTdivF_mV) )*(Epsilon_pi-Epsilon_ps) ;
	t_sw = t_fwd ;
	t_rev = ( Eref_mV / (Xi400*RTdivF_mV) )*(Epsilon_pf-Epsilon_ps) ;


	t_tot_s = t_tot*refTime_s ;
	t_fwd_s = t_fwd*refTime_s ;
	t_sw_s = t_fwd_s ;
	t_rev_s = t_rev*refTime_s ;

# Save dimensionless parameters for use later if needed

	jldopen("temp/fromDimlessGrpCalcs.jld", "w") do file
		write(file, "Alpha", Alpha)
		write(file, "RsCd_s", RsCd_s)
		write(file, "maxCapCurrent_uA", maxCapCurrent_uA)
		write(file, "Temp_K", Temp_K)
		write(file, "RTdivF_mV", RTdivF_mV)
		write(file, "FarConst_uA", FarConst_uA)
		write(file, "refCurrent_uA", refCurrent_uA)
		write(file, "Xi400", Xi400)
		write(file, "refTime_s", refTime_s)
		write(file, "wHalf_p", wHalf_p)
		write(file, "wHalf_y", wHalf_y)
		write(file, "tauCap", tauCap)
		write(file, "zetaCap", zetaCap)
		write(file, "phiP", phiP)
		write(file, "Eref_mV", Eref_mV)
		write(file, "Epsilon_pi", Epsilon_pi)
		write(file, "Epsilon_ps", Epsilon_ps)
		write(file, "Epsilon_pf", Epsilon_pf)
		write(file, "kappa_py_p", kappa_py_p)
		write(file, "kappa_py_y", kappa_py_y)
		write(file, "t_tot", t_tot)
		write(file, "t_fwd", t_fwd)
		write(file, "t_sw", t_sw)
		write(file, "t_rev", t_rev)
		write(file, "t_tot_s", t_tot_s)
		write(file, "t_fwd_s", t_fwd_s)
		write(file, "t_sw_s", t_sw_s)
		write(file, "t_rev_s", t_rev_s)
		write(file, "gBard", gBard)
		write(file, "refCurrent_AdsMono_uA", refCurrent_AdsMono_uA)
		write(file, "Gamma_pmol_cm2", Gamma_pmol_cm2)
		write(file, "G_Laviron", G_Laviron)
		write(file, "peakPotentialLaviron_mV", peakPotentialLaviron_mV)
		write(file, "psiLaviron_uA", psiLaviron_uA)
	end

# Return values that are needed

	return scanRate_mVps,FarConst_uA,
	Ptot_cm3,Ytot_cm3,k_py_cm3,
	Dp_cm2_s,Dy_cm2_s,
	discArea_cm2,filmThickness_cm,
	k0_cm,Alpha,
	Ei_mV,Es_mV,Ef_mV,Ep0_mV,
	Rs_Ohm,Cd_F,Cd_uA_mV,RsCd_s,maxCapCurrent_uA,
	Temp_K,RTdivF_mV,
	refCurrent_uA,Xi400,refTime_s,
	wHalf_p,wHalf_y,
	tauCap,zetaCap,
	phiP,Eref_mV,Epsilon_pi,Epsilon_ps,Epsilon_pf,
	kappa_py_p,kappa_py_y,
	t_tot,t_fwd,t_sw,t_rev,
	t_tot_s,t_fwd_s,t_sw_s,t_rev_s,gBard,refCurrent_AdsMono_uA,Gamma_pmol_cm2,G_Laviron,peakPotentialLaviron_mV,psiLaviron_uA

#-----

end
