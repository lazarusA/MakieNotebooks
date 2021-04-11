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

function FigGridHeatSharedCbarH()
    fig = Figure(resolution = (600, 400))
    axes = []
    c = 1
    for i in 1:1, j in 1:2
        ax = fig[i, j] = Axis(fig, xgridvisible = false, ygridvisible = false)
        pnts = heatmap!(rand(10,10), colormap= :thermal, colorrange=(0, 1))
        ax.xticks = [1,9]
        ax.yticks = [1,9]
        cbar = Colorbar(fig, pnts, vertical = false, 
        labelpadding = -10, ticklabelalign = (:center, :center),
        ticklabelpad = 7, flipaxisposition=false,  
        width = Relative(3/4), height = 15, tickwidth = 2, ticklabelsize = 14)
        cbar.ticks = [0,0.5,1]
        fig[2, 1:2] = cbar
        c+=1
        push!(axes, ax)
    end
    hideydecorations!(axes[2])
    fig
end
fig = FigGridHeatSharedCbarH()
#save("/results/FigGridHeatSharedCbar.svg", fig, pt_per_unit = 0.7);
save("FigGridHeatSharedCbarH.png", fig, px_per_unit = 2)
fig