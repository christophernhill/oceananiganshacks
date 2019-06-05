function tdsolve(ld,md,ud,rhs)
# Tridoagonal solve per Numerical Recipes, Press et. al 1992 (Sec  2.4 )
# ld[2:N  ] - lower diagonal
# md[1:N  ] - main diagonal
# ud[1:N-1] - upper diagonal
# phi       - solution vector
# rhs       - right hand side
 # Get length and allocate memory
 # return rhs
 N=length(rhs)
 phi=rhs.*typeof(rhs[1])(0)
 gamma=rhs.*typeof(rhs[1])(0)
 #       
 beta=md[1]
 phi[1]=rhs[1]/beta

 for j=2:N
  gamma[j]=ud[j-1]/beta
  beta=md[j]-ld[j]*gamma[j]
  # beta small should only happen on last element of forward pass for 
  # problem with zero eigenvalue. In that case algorithmn is still stable.
  if abs(beta) < 1.e-12
   break
  end
  phi[j]=(rhs[j]-ld[j]*phi[j-1])/beta
 end
 for j=1:N-1
  k=N-j
  phi[k]=phi[k]-gamma[k+1]*phi[k+1]
 end
 return phi
end
