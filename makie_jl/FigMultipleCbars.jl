# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie # using GLMakie
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

x = LinRange(0,2π,50) # with 50 points in the interval.

fig = Figure(resolution = (900, 450), font =:sans)
ax = Axis(fig, xlabel = "x", ylabel = "")

line1 = lines!(x, sin.(x), color = x,  colormap = :thermal, linewidth = 2)
line2 = lines!(x, cos.(x), color = sqrt.(x),  colormap = :ice,linewidth = 2)
line3 = lines!(x, -sin.(x), color = x.^2, colormap = :viridis,linewidth = 2)
line4 = lines!(x, -cos.(x), color = x/2, colormap = :plasma,linewidth = 2)
lineas = [line1, line2, line3, line4]
labels = ["x", "sqrt(x)", "x^2", "x/2"]
cbars = [Colorbar(fig, lineas[i], label = labels[i]) for i in 1:4]
fig[1, 1] = ax
fig[1, 2] = cbars[1]
fig[1, 3] = cbars[2]
fig[1, 4] = cbars[3]
fig[1, 5] = cbars[4]
#save("/results/FigMultipleCbars.svg", scene, pt_per_unit = 0.7);
save("FigMultipleCbars.png", fig, px_per_unit = 2)
fig