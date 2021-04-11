# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie
using Random
Random.seed!(34)

set_theme!(
    rowgap = 5,
    colgap = 5, 
    fontsize = 16, 
    font =:sans,
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
        height = Relative(4/4), 
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

rline(x; b=1, m = 1) = m*x + b
x = 0:0.05:1
y1 = rline.(x, m = 0.6)

x = 0:0.05:1
y1 = rline.(x, m = 0.6)
σ = 0.1* rand(length(x))
y1up = y1 .+ σ
y1do = y1 .- σ

y2 = rline.(x; b = 1.5, m = -0.7)
y2up = y2 .+ σ
y2do = y2 .- σ

fig = Figure(resolution = (600, 400))
ax = Axis(fig, xlabel = "x", ylabel = "y")
lines!(x, y1, color = :red)
band!( x, y1do, y1up; color = (:red, 0.2))
band!( x, y2do, y2up; color = (:black, 0.2))
fig[1, 1] = ax
#save("./results/FigFilled5.svg", fig, pt_per_unit = 0.7)
save("FigFilledConfidenceInterval2.png", fig, px_per_unit = 2)
fig