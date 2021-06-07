function Pox_ODE_Coefficients(P_ODE,h,numPts,wHalf_p,Xi400,Alpha,Eref_mV,RTdivF_mV,phiP,kappa_py_p,gBard)

        # Parameters for the ODEs corresponding to the oxidized form of the redox film mediator (Pox)

    			eqnNum = 1 ;

    			offset = numPts*(eqnNum-1) ;
    				# offset accounts for the fact that the ODEs for each species are vertically stacked

    			# Electrode Surface, Pox

    			   P_ODE[1+offset,100] = (h[1]/2)*(wHalf_p^2)*(1/Xi400) ;

    			   P_ODE[1,99] = Alpha ;

    			   P_ODE[1+offset,98] = gBard  ;

    			   P_ODE[1+offset,1] = -phiP ;

    			   P_ODE[1+offset,2] = phiP ;

    			   P_ODE[1+offset,3] = 1/h[1] ;


    			   P_ODE[1+offset,101] = P_ODE[1,1]/P_ODE[1,100] ;

    			   P_ODE[1+offset,102] = P_ODE[1,2]/P_ODE[1,100] ;

    			   P_ODE[1+offset,103] = P_ODE[1,3]/P_ODE[1,100] ;


    		   # Interior, Pox

    			   for i=2:(numPts-1)

    				   # global numPts

    				   Parti1a = (h[i-1]+h[i])/2 ;
    				   Parti1b = wHalf_p^2 ;
    				   Parti1c = (1/Xi400) ;

    				   P_ODE[i+offset,100] = (Parti1a)*(Parti1b)*(Parti1c) ;

    				   P_ODE[i+offset,1] = -1/h[i-1] ;

    				   P_ODE[i+offset,2] = 1/h[i] ;

    				   P_ODE[i+offset,101] = P_ODE[i,1]/P_ODE[i,100] ;

    				   P_ODE[i+offset,102] = P_ODE[i,2]/P_ODE[i,100] ;


    			   end

    	   # Film Edge, Pox

    		   P_ODE[numPts+offset,100] = (h[(numPts-1)]/2)*(wHalf_p^2)*(1/Xi400) ;

    		   P_ODE[numPts+offset,1] = -1/h[(numPts-1)] ;

    		   P_ODE[numPts+offset,101] = P_ODE[numPts,1]/P_ODE[numPts,100] ;


return P_ODE

end
