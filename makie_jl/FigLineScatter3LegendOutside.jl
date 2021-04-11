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
fig = Figure(resolution = (650, 400), font =:sans)
ax = Axis(fig, xlabel = "x", ylabel = "")

line1 = lines!(x, sin.(x), color = :red)
line2 = lines!(x, cos.(x), color = :blue)
points1 = scatter!(x, cos.(x), color = :black, markersize = 5)
points2 = scatter!(x, -cos.(x), color = :red, strokecolor = :red, 
    markersize = 5, marker = '■')
leg = Legend(fig, [line1, [line2, points1], points2], markersize = 7,
    [" sin(x)", " cos(x)",  "-cos(x)"], "f(x)", 
  tellheight =false, tellwidth = true, valign = :center)
fig[1, 1] = ax
fig[1, 2] = leg
#save("/results/FigLegendOut.svg", scene, pt_per_unit = 0.7);
save("FigLegendOut.png", fig, px_per_unit = 2)
fig