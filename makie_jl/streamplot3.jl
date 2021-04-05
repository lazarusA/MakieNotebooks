using GLMakie

nonStablePoincare(x,y) = Point(x*(x^2+y^2-1) - y*(x^2+y^2+1),y*(x^2+y^2-1) + x*(x^2+y^2+1))
stableVanDerPaul(x,y) = Point(y, (1-x^2)*y -x)
semiStable(x,y) = Point(-y+ x*(-1+x^2+y^2)^2, x+y*(-1+x^2+y^2)^2) 

fig = Figure(resolution = (900, 400))
ax1 = fig[1, 1] = Axis(fig, aspect = DataAspect(), 
    xlabel = "x", ylabel = "y", title = "non-stable")
ax2 = fig[1, 2] = Axis(fig, aspect = DataAspect(), 
    xlabel = "x", title = "stable")
ax3 = fig[1, 3] = Axis(fig, aspect = DataAspect(),
    xlabel = "x", title = "semi-stable")

streamplot!(ax1, nonStablePoincare, -4..4, -4..4, colormap = :plasma, 
    gridsize= (32,32), arrow_size = 0.07)

streamplot!(ax2, stableVanDerPaul, -4..4, -4..4, colormap = :viridis, 
    gridsize= (32,32), arrow_size = 0.07)
streamplot!(ax3, semiStable, -4..4, -4..4, colormap = :rainbow1, 
    gridsize= (32,32), arrow_size = 0.07)
hideydecorations!(ax2, grid = false)
hideydecorations!(ax3, grid = false)
limits!(ax1, -4, 4, -4, 4)
limits!(ax2, -4, 4, -4, 4)
limits!(ax3, -4, 4, -4, 4)
fig
save("odeField3.png", fig)