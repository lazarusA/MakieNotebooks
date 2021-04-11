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

x = y = -10:0.11:10
y1d =  sin.(x) ./ x 
# 3D heatmap
sinc2d(x,y) = sin.(sqrt.(x.^2 + y.^2))./sqrt.(x.^2+y.^2)
fxy = [sinc2d(x,y) for x in x, y in y]

fig = Figure(resolution = (600, 400))
ax1 = Axis(fig, xlabel = "x", ylabel = "", xgridvisible = true, ygridvisible = true)
ax2 = Axis(fig,aspect=1, bbox = BBox(120, 220, 260, 360),
    xtickalign=0, ytickalign=0, xlabel = "x", ylabel = "y",
    ylabelpadding = 1, xlabelpadding=1, xticklabelsize = 12, yticklabelsize = 12
  #title = "inset  at (120, 220, 260, 360)"
)

line1 = lines!(ax1, x, y1d, color = :red)
# inset
hmap = heatmap!(ax2, x, y,fxy, colormap = :plasma)
limits!(ax2, -10,10,-10,10)
hidespines!(ax2)
ax2.yticks = [-10,0,10]
ax2.xticks = [-10,0,10]

leg = Legend(fig, [line1], ["sinc(x)"], halign = :right, valign = :top)
cbar = Colorbar(fig, hmap, label ="sinc(x,y)", labelpadding = 5, 
    tellheight = false, tellwidth = false,ticklabelsize = 12, 
    width = 10, height = Relative(1.5/4), halign = :right, valign = :center)

fig[1, 1] = ax1
fig[1, 1] = leg
fig[1, 1] = cbar
save("FigInset2.png", fig, px_per_unit = 1)
fig