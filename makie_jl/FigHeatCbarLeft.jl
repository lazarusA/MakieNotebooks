# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, Random # using GLMakie
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
Random.seed!(123)
fig = Figure(resolution = (500, 400), font =:serif)
ax = Axis(fig,  aspect = 1,xlabel = "x", ylabel = "y", xgridvisible = false, ygridvisible = false)
hmap = heatmap!(rand(10,20), colormap = :thermal)
cbar = Colorbar(fig, hmap, label = "value", labelpadding = -5, flipaxisposition= false, 
    ticklabelpad = 30)
fig[1, 1] = cbar
fig[1, 2] = ax
#save("/results/FigHeatCbarLeft.svg", scene, pt_per_unit = 0.7);
save("FigHeatCbarLeft.png", fig, px_per_unit = 2)
fig