using GLMakie 
odeSol(x,y) = Point(-x, 2y) # x'(t) = -x, y'(t) = 2y
fig = Figure(resolution =(400,400))
ax = Axis(fig)
streamplot!(ax, odeSol, -2..2, -2..2, colormap = :plasma, 
    gridsize= (32,32), arrow_size = 0.07)
fig[1,1] = ax
save("odeField.png", fig)
fig