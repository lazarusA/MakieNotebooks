# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors

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

using Random
Random.seed!(123)

x = -3:0.05:3
y = exp.(-x.^2)
n=15
y[1:n] = y[1:n] .+ 0.02*randn(n)

fig = Figure(resolution = (600, 400))
ax1 = Axis(fig, xlabel = "x", ylabel = "f(x)",
    xgridvisible = false, 
    ygridvisible = false)
ax2 = Axis(fig, bbox = BBox(140, 260, 260, 350),
    xticklabelsize = 12, yticklabelsize = 12,showgrid=false,
  #title = "inset  at (100, 300, 100, 200)"
)
line1 = lines!(ax1, x, y, color = :red)
# inset
lines!(ax2, x, y, color = :red)
limits!(ax2, -3.1,-1.9,-0.05,0.05)
ax2.yticks = [-0.05,0,0.05]
ax2.xticks = [-3,-2.5,-2]
leg = Legend(fig, [line1], ["f(x)"], halign = :right, valign = :top)

fig[1, 1] = ax1
fig[1, 1] = leg
save("FigInset1.png", fig, px_per_unit = 1)
fig