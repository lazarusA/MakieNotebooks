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
fig = Figure(resolution = (400, 500), font =:serif)
ax = Axis(fig,  aspect = 1, xlabel = "x", ylabel = "y", xtickalign = 0,  ytickalign = 0, 
           xgridvisible = false, ygridvisible = false)
hmap = heatmap!(rand(10,20), colormap = :ice)
hidespines!(ax)
cbar = Colorbar(fig, hmap, label = "value", vertical = false,
    labelpadding = -5, ticklabelpad= 7, ticklabelalign = (:center, :center), 
    width = Relative(1), height = 15, tickalign = 0)
fig[1, 1] = cbar
fig[2, 1] = ax
#save("/results/FigHeatCbarTop.svg", scene, pt_per_unit = 0.7);
save("FigHeatCbarTop.png", fig, px_per_unit = 2)
fig