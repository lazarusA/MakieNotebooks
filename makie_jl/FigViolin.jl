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
# the actual violin is here !!! 
Random.seed!(13)
b = randn(1000)
a = fill(1, length(b))

fig = Figure(resolution = (600, 400), font = "sans")
ax2 = Axis(fig, xlabel = "variable", ylabel = "values", xticks = ([1],["normal Distribution"]) )
violin!(a, b; width = 0.35,  color = (:yellow, 0.45), 
    strokecolor =:black, show_median = true, mediancolor = :black)
limits!(ax2,0,2,-5,5)
fig[1,1] = ax2
save("FigViolin.png", fig, px_per_unit = 2)
fig
