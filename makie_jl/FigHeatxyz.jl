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

x = y = -5:1:5
z = [x^2 + y^2 for x in x, y in y]
fig = Figure(resolution = (450, 400))
ax  = Axis(fig, aspect = 1, xlabel = "x", ylabel = "y",
  title = "Discrete Heat map", xtickalign = 0,  ytickalign = 0)
hmapxyz = heatmap!(x, y, z, colormap = :thermal)
ax.xticks = [-4,-2,0,2,4]
ax.yticks = [-4,-2,0,2,4]
limits!(ax, -5.0, 5.0, -5.0, 5.0)
cbar  = Colorbar(fig, hmapxyz, label ="z", labelpadding = 0)
fig[1, 1] = ax
fig[1, 2] = cbar
#save("./results/FigHeatxyz.svg", scene, pt_per_unit = 0.7);
save("FigHeatxyz.png", fig, px_per_unit = 2)
fig

#Be careful ! the ticks are wrong!, there is an open issue about this. 
#https://github.com/JuliaPlots/Makie.jl/issues/661