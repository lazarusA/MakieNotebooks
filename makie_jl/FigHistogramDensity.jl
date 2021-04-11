# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using StatsBase, KernelDensity, Colors, LinearAlgebra
using Random
using CairoMakie, ColorSchemes # using GLMakie

set_theme!(
    rowgap = 5,
    colgap = 5, 
    fontsize = 14, font =:sans,
    Axis = (
        xgridcolor = "#eee4da", 
        ygridcolor = "#eee4da", 
        backgroundcolor = :white,
        xgridstyle=:dash, 
        ygridstyle=:dash, 
        xgridwidth=1, 
        ygridwidth=1, 
        xtickalign=1, 
        ytickalign=1, #xtickcolor = :red, ytickcolor = :white,
        rightspinevisible = false,
        topspinevisible = false,
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
        labelsize = 14, 
        linewidth = 2,
        margin = (10, 10, 10, 10), 
        framevisible = true)
)

Random.seed!(13)
b = randn(1000)

fig = Figure(resolution = (600, 400), font = "sans")
ax4 = Axis(fig, xlabel = "value", ylabel = "" )
h = fit(Histogram, b, nbins = 50)
h = normalize(h)
#histogram
plot!(ax4, h, color = (:dodgerblue, 0.25), strokecolor = :black, strokewidth = 0.5)
# density distribution
d = kde(b)
linec = lines!(d.x, d.density, color = :orangered, linewidth = 1.5)
bandc = band!(d.x, 0*d.density, d.density, color = (:yellow, 0.25))
leg = Legend(fig, [[linec, bandc]], ["density"], framevisible = true,
    tellheight = false, tellwidth = false, halign = :right, valign = :top)
fig[1,1] = ax4
fig[1,1] = leg
save("FigHistogramDensity.png", fig, px_per_unit = 2)
fig