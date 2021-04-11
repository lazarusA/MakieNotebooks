# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie

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

x = LinRange(-10,10,200)
fg(x,μ,σ) = exp.(.-(x.-μ).^2 ./(2σ^2))./(σ*√(2π))

fig = Figure(resolution = (600, 400))
ax = Axis(fig, xlabel = "x", ylabel = "y")
# filled curve 1
linea1 = lines!(x, fg(x, 0.25, 1.5), color = "#E69F00")
fillB1 = band!( x, fill(0,length(x)), fg(x, 0.25, 1.5); color = ("#E69F00", 0.1))
# filled curve 2
linea2 = lines!(x, fg(x, 2, 1), color = "#56B4E9")
fillB2 = band!( x, fill(0,length(x)), fg(x, 2, 1); color = ("#56B4E9", 0.1))
# filled curve 3
linea3 = lines!(x, fg(x, -1, 2), color = "#009E73")
fillB3 = band!( x, fill(0,length(x)), fg(x, -1, 2); color = ("#009E73", 0.1))
leg = Legend(fig, [[linea1, fillB1], [linea2, fillB2], [linea3, fillB3]], 
    ["μ = 0.25, σ = 1.25", "μ = 2, σ = 1", "μ = -1, σ = 2"], halign = :left, valign = :top)
fig[1, 1] = ax
fig[1, 1] = leg
#save("./results/FigFilled2.svg", fig, pt_per_unit = 0.7);
save("FigFilledGaussians.png", fig, px_per_unit = 2)
fig