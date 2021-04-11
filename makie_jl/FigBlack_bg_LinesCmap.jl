# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie

set_theme!(
    rowgap = 5,
    colgap = 5,
    fontsize = 16, 
    backgroundcolor = :black, # "#212946",
    Axis = (
        xgridcolor = :white, 
        ygridcolor = :white, 
        backgroundcolor = :black, # "#212946",
        xgridstyle=:dash, 
        ygridstyle=:dash, 
        xgridwidth=0.35, 
        ygridwidth=0.35, 
        xtickalign=0, 
        ytickalign=0, 
        xtickcolor = :white, 
        ytickcolor = :white,
        bottomspinecolor = :white, 
        topspinecolor =:white,
        leftspinecolor =:white,
        rightspinecolor =:white,
        xlabelcolor=:white, 
        ylabelcolor = :white,
        xticklabelcolor = :white, 
        yticklabelcolor = :white,
        xgridvisible = true, 
        ygridvisible = true),
    Colorbar = (
        topspinevisible = false, 
        rightspinevisible = false,
        bottomspinevisible = false, 
        leftspinevisible = false,
        width = 12, 
        height = Relative(4/4), 
        labelcolor = :white,
        ticklabelcolor = :white,
        tickalign = 1, 
        tickcolor = :white, 
        labelpadding = -5, 
        ticklabelsize = 16),
    Legend = (#titlecolor = :white # not working or missing
        tellheight = false, 
        tellwidth = false, 
        halign = :right, 
        valign = :top, 
        labelsize = 16,
        linewidth = 2,
        markersize = 7, 
        margin = (10, 10, 10, 10),
        framevisible = true, 
        framecolor = (:white, 0.25),
        bgcolor = (:grey, 0.25), 
        labelcolor = :white, 
        titlecolor = :white)
)

xs = 0:0.01:1
p = -10:1:10
p = filter(x->x != 0,collect(p))
ys = zeros(length(xs), length(p))
for (indx,i) in enumerate(p)
    if i <= -1
        ys[:,indx]= xs .^(1/abs(i))
    elseif i>= 1
        ys[:,indx]= xs .^i
    end
end

cmap = get(colorschemes[:Wistia], LinRange(0,1,length(p)))
fig = Figure(resolution = (470, 400), font = :sans)
ax   =  Axis(fig, aspect = 1, xlabel = "x", ylabel ="x^p")
lins = [lines!(xs, ys[:,v], color = cmap[v]) for v in 1:length(p)]
cbar = Colorbar(fig, limits =(-10.01,10.01), nsteps = length(p), 
    colormap = :Wistia, label ="p")
fig[1, 1] = ax
fig[1, 2] = cbar
#save("/results/FigBlackBackground.svg", fig, pt_per_unit = 0.7);
save("FigBlack_bg_LinesCmap.png", fig, px_per_unit = 1);
fig