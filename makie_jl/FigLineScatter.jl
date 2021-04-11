# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie # using GLMakie
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

x = LinRange(0,2π,50) # with 50 points in the interval.
fig = Figure(resolution = (600, 400), font =:sans)
ax = Axis(fig, xlabel = "x", ylabel = "")
line1 = lines!(x, sin.(x), color = :black)
pnts1 = scatter!(x, sin.(x), color = :black, markersize = 5)
leg = Legend(fig, [[line1, pnts1]], ["sin(x)"], markersize = 7,
              halign = :right, valign = :top, bgcolor = :transparent)
fig[1, 1] = ax
fig[1, 1] = leg
#save("./results/FigLineScatter.svg", scene, pt_per_unit = 0.7);
save("FigLineScatter.png", fig, px_per_unit = 2)
fig