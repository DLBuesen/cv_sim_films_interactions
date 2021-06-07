# Defining a function for dimensionless potential as a function of time

	 function Epsilon_CV(t,t_sw,t_tot,RTdivF_mV,Eref_mV,Xi400,Epsilon_pi,Epsilon_pf)

		 if 0 <= t <= t_sw
		   Epsilon = Epsilon_pi - (Xi400*RTdivF_mV/Eref_mV)*t ;
	     elseif t_sw <= t <= t_tot
		   Epsilon = Epsilon_pf + (Xi400*RTdivF_mV/Eref_mV)*(t-t_tot) ;
	     elseif t > t_tot ;
		    Epsilon = Epsilon_pf + (Xi400*RTdivF_mV/Eref_mV)*(t-t_tot) ;
		 end
	 end
