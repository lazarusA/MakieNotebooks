using GLMakie 

testField(x,y) = Point(-x, 2y)
x =  -2:0.1:2
y =  -2:0.1:2
u(x,y) = -x
v(x,y) = 2y
z = [log10(sqrt(u(x,y)^2 + v(x,y)^2)) for x in x, y in y]

fig = Figure(resolution = (500, 400))
ax = fig[1, 1] = Axis(fig, aspect = DataAspect(), 
    xlabel = "u", ylabel = "v", xticklabelsize=14, yticklabelsize=14)
fs = heatmap!(ax, x, y, z, colormap = :magma)
streamplot!(ax, testField, x, y, colormap = :magma,
    gridsize= (32,32), arrow_size = 0.04)
limits!(ax, -2, 2, -2, 2)
cbar = fig[1,2] = Colorbar(fig, fs, label = "log10[(u²+v²)½]", 
    labelsize = 14, ticklabelsize=14)
cbar.width = 12
cbar.height = Relative(3.7/4)
fig
#save("odeField2.png", fig)