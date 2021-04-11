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
n = 15
x, y, color = rand(n), rand(n), rand(n)
cmaps = [:cool, :viridis, :plasma, :inferno, :thermal,
    :leonardo, :winter, :spring, :ice]
markers = [:+, :diamond, :star4, :rtriangle, :rect,
    :circle, :pentagon, :cross, :star5]

function FigGridHeatSharedCbar()
    fig = Figure(resolution = (500, 400))
    c = 1
    for i in 1:2, j in 1:2:3
        ax = fig[i, j] = Axis(fig, aspect = 1, xgridvisible = false, ygridvisible = false)
        pnts = heatmap!(rand(10,10), colormap= cmaps[j], colorrange=(0, 1))
        ax.xticks = [0,10]
        ax.yticks = [0,10]
        ax.xticklabelsize = 14
        ax.yticklabelsize = 14

        cbar = Colorbar(fig, pnts, ticklabelsize = 12, height = Relative(3/4), tickwidth = 2)
        cbar.ticks = [0, 0.5, 1]
        fig[1:2, j+1] = cbar
        c+=1
    end
    fig
end
fig = FigGridHeatSharedCbar()
#save("/results/FigGridHeatSharedCbar.svg", fig, pt_per_unit = 0.7);
save("FigGridHeatSharedCbar.png", fig, px_per_unit = 2)
fig