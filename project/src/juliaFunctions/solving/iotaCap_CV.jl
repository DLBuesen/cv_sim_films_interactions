# Defining a function for the capacitive current contribution

	function iotaCap_CV(t,t_sw,t_tot,tauCap,zetaCap)

	  if 0 <= t <= t_sw
			Part1 = 1-exp(-3*t/tauCap) ;
			Part2 = -zetaCap*Part1 ;
		  iotaCap = Part1*Part2 ;
	  elseif t_sw <= t <= t_tot
		  Part1 = 1-exp(-3*(t-t_sw)/tauCap) ;
		  Part2 = zetaCap*Part1 ;
		iotaCap = Part1*Part2 ;
	  elseif t > t_tot ;
		  Part1 = 1-exp(-3*(t-t_sw)/tauCap) ;
		  Part2 = zetaCap*Part1 ;
		iotaCap = Part1*Part2 ;
	  end

	end
