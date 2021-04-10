using CairoMakie, ColorSchemes
set_theme!(
    rowgap = 5,
    colgap = 5, 
    fontsize = 16, font =:sans,
    Axis = (
        xgridcolor = :black, 
        ygridcolor = :black, 
        backgroundcolor = :white,
        xgridstyle=:dash, 
        ygridstyle=:dash, 
        xgridwidth=0.15, 
        ygridwidth=0.15, 
        xtickalign=1, 
        ytickalign=1, #xtickcolor = :red, ytickcolor = :white,
        xgridvisible = true, 
        ygridvisible = true),
    Colorbar = (
        topspinevisible = false, 
        rightspinevisible = false,
        bottomspinevisible = false, 
        leftspinevisible = false,
        width = 12, 
        height = Relative(1), 
        tickalign = 1, 
        labelpadding = -5),
    Legend = (
        tellheight = false, 
        tellwidth = false, 
        halign = :left, 
        valign = :bottom, 
        labelsize = 14, 
        linewidth = 2,
        margin = (10, 10, 10, 10), 
        framevisible = true)
)
#The actual plot starts here. 

x = LinRange(0,2π,50) # with 50 points in the interval.
fig = Figure(resolution = (650, 500), font =:sans)
ax = Axis(fig, xlabel = "x", ylabel = "y")

line1 = lines!(x, sin.(x), color = x,  colormap = :thermal, linewidth = 2)
line2 = lines!(x, cos.(x), color = sqrt.(x),  colormap = :ice,linewidth = 2)
line3 = lines!(x, -sin.(x), color = x.^2, colormap = :viridis,linewidth = 2)
line4 = lines!(x, -cos.(x), color = x/2, colormap = :plasma,linewidth = 2)
#lineas = [line1, line2, line3, line4]
labels = ["x", "sqrt(x)", "x^2", "x/2"]
cbar1 = Colorbar(fig, line1, label = labels[1],
    # cbar's frame
    topspinevisible = true, 
    bottomspinevisible = true, 
    leftspinevisible = true,
    rightspinevisible = true)
cbar2 = Colorbar(fig, line2, label = labels[2], labelpadding = -5,
    flipaxisposition= false, ticklabelpad = 30, height = Relative(3.5/4),
    # cbar's frame
    topspinevisible = true, 
    bottomspinevisible = true, 
    leftspinevisible = true,
    rightspinevisible = true)
cbar3 = Colorbar(fig, line3, label = labels[3], vertical = false, 
    labelpadding = -10, ticklabelalign = (:center, :center),
    ticklabelpad = 7, flipaxisposition=false,  
    width = Relative(4/4), height = 10, tickcolor = :red)
cbar4 = Colorbar(fig, line4, label = labels[4], vertical = false,
    labelpadding = -5, ticklabelpad= 7, ticklabelalign = (:center, :center), 
    width = Relative(3/4), height = 10,
    # cbar's frame
    topspinevisible = false, 
    bottomspinevisible = true, 
    leftspinevisible = true,
    rightspinevisible = true)
fig[1, 2] = cbar4
fig[2, 1] = cbar2
fig[2, 2] = ax
fig[2, 3] = cbar1
fig[3, 2] = cbar3
#save("/results/Fig4barsAround.svg", scene, pt_per_unit = 0.7);
#save("./results/Fig4barsAround.png", fig, px_per_unit = 2)
fig