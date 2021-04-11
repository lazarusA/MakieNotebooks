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
x = 0:0.3:4
a = exp.(- x)
b =  exp.(- x.^2)

fig = Figure(resolution = (600,400), font = :sans)
ax   =  Axis(fig, xlabel = "x", ylabel ="y")
lina = lines!(x, a, color = ("#08F7FE",0.8))
glowA = [lines!(x, a, color = ("#08F7FE", 0.09), linewidth = 1 + 0.8*i) for i in 1:10]
linb = lines!(x, b, color = ("#FFE64D",0.8))
glowB = [lines!(x, b, color = ("#FFE64D", 0.09), linewidth = 1 + 0.8*i) for i in 1:10]
pnta = scatter!(x, a, color = "#08F7FE", markersize=5, 
    strokecolor = "#08F7FE", glowwidth = 2, glowcolor = "#08F7FE")


fillA = band!(x, fill(0,length(x)), a; color = ("#08F7FE", 0.08))

pntb = scatter!(x, b, color = "#FFE64D", markersize=5, 
    strokecolor = "#FFE64D", glowwidth = 2, glowcolor ="#FFE64D")
fillB = band!(x, a, b; color = ("#FFE64D", 0.08))


leg = Legend(fig, [[lina, pnta], [linb, pntb]], ["exp(-x)", "exp(-x²)"])

fig[1, 1] = ax
fig[1, 1] = leg
save("FigBlue_bgGlow_Lines.png", fig, px_per_unit = 2);
fig