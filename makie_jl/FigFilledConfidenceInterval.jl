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

x = y = -10:0.11:10
y1d =  sin.(x) ./ x 
lower = y1d .- 0.1
upper = y1d .+ 0.1

fig = Figure(resolution = (600, 400))
ax = Axis(fig, xlabel = "x", ylabel = "y")
lines!(x, y1d, color = :red)
band!(x, lower, upper; color = ("#E69F00", 0.2))
fig[1,1] = ax
#save("./results/FigFilled4.svg", fig, pt_per_unit = 0.7);
save("FigFilledConfidenceInterval.png", fig, px_per_unit = 2)
fig