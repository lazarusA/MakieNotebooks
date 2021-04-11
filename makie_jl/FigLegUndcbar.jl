# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes # using GLMakie
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

x = LinRange(0,2π,100) # with 100 points in the interval.
fig = Figure(resolution = (650, 400), font =:sans)
ax = Axis(fig, xlabel = "x", ylabel = "")
line1 = lines!(x, sin.(x), color = x,  colormap = :thermal, linewidth = 2)
line2 = lines!(x, cos.(x), color = :black,  linewidth = 1)
line3 = lines!(x, -cos.(x), color = :dodgerblue)
#limits!(ax, 0,2π,-1.01,1.01)
leg = Legend(fig, [line2, line3], ["  sin(x)", "- cos(x)"])
cbar1 = Colorbar(fig, line1, label = "cos(x)", ticklabelsize = 14, 
    labelpadding = 5, width = 10)
fig[1, 1] = ax
fig[1, 1] = leg
fig[1, 2] = cbar1
#save("/results/FigLegUndcbar.svg", scene, pt_per_unit = 0.7);
save("results/FigLegUndcbar.png", fig, px_per_unit = 2)
fig