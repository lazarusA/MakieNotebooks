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
function ngonShape(h, k, r, n)
    x = [h .+ r*sin.(m*2π/n) for m in 1:n]
    y = [k .+ r*cos.(m*2π/n) for m in 1:n]
    x, y
end

function ngonShapes()
    cmap = get(colorschemes[:Spectral_11], LinRange(0,1,36))
    cmap = reshape(cmap, (6,6)) 
    fig = Figure(resolution = (800, 500), font = :sans)
    ax  = Axis(fig,aspect = DataAspect(), xlabel = "x", ylabel ="y")
    c = 1
    for i in 1:6, j in 1:3
        x, y = ngonShape(i, j, 0.45, 2 + c)
        x, y = push!(x, x[1]), push!(y, y[1])
        lines!(x,y, color = (cmap[i,j], 1), linewidth = 1) 
        poly!((x,y), color = (cmap[i,j], 0.12))
        annotations!(["$(c+2)"], [Point.(i-0.06,j-0.08)], textsize = 0.2, color = :white)
        c += 1
    end
    fig[1,1]= ax
    fig
end
fig = ngonShapes()
save("FigngonShapes.png", fig, px_per_unit = 2)
fig