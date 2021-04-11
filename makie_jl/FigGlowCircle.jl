# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)

using CairoMakie, ColorSchemes, Colors # using GLMakie
# our black blackground 
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

function circleShape(h,k; r= 1, n = 100)
    θ = 0:360÷n:360
    r*sind.(θ) .+ h, r*cosd.(θ) .+ k
end

cmap = reverse(get(colorschemes[:Spectral_10], LinRange(0,1,30))) # deep
cmap = reshape(cmap, (5,6))

fig = Figure(resolution = (400, 400), font = :sans)
ax  = Axis(fig,aspect = DataAspect(), xlabel = "x", ylabel ="y")
poly!(circleShape(0,0), color = (cmap[4,4], 0.1))
# glow at the edge
[lines!(circleShape(0,0), color = (cmap[4,4], 0.08), linewidth = 0.8 + 2*i) for i in 1:10]

fig[1,1] = ax
save("FigGlowCircle.png", fig, px_per_unit = 2)
fig