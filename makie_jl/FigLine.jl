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

x = -2π:0.1:2π
fig = Figure(resolution = (600, 400), font = "Avenir Light")
ax = Axis(fig, xlabel = "x", ylabel = "f(x)")
line1 = lines!(x, sin.(x), color = "#56B4E9", linewidth = 2)
line2 = lines!(x, cos.(x), color = :black, linewidth = 2, linestyle = :dash)
leg = Legend(fig, [line1, line2], ["sin(x)", "cos(x)"])
fig[1, 1] = ax
fig[1, 1] = leg
#save("/results/FigLabels.svg", scene, pt_per_unit = 0.7);
save("FigLine.png", fig, px_per_unit = 2)
fig