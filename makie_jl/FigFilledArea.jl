# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie

set_theme!(
    rowgap = 5,
    colgap = 5, 
    fontsize = 16, 
    font =:sans,
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
        height = Relative(4/4), 
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

x = 0:0.05:1
y = x.^2
fig = Figure(resolution = (600, 400))
ax = Axis(fig, xlabel = "x", ylabel = "y")
linea = lines!(x, y, color = :dodgerblue)
fillB = band!(x, fill(0,length(x)), y; color = (:dodgerblue, 0.1))
leg = Legend(fig, [[linea, fillB]], ["Label"], halign = :left, valign = :top)
fig[1, 1] = ax
fig[1, 1] = leg
#save("./results/FigFilled1.svg", fig, pt_per_unit = 0.7);
save("FigFilledArea.png", fig, px_per_unit = 2)
fig