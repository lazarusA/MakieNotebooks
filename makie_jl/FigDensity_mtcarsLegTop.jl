using RDatasets, StatsBase, KernelDensity, Colors
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
cars = dataset("datasets", "mtcars")
byCat = cars.Cyl
categ = unique(byCat)
fig = Figure(resolution = (600, 450), font = "Avenir Light")
ax = Axis(fig, xlabel = "MPG", ylabel = "density")
colors = ColorScheme(range(colorant"yellow", colorant"#65ADC2", length=length(categ)))
legends = []
for (i,c) in enumerate(sort(categ))
    indc = findall(x->x == c, byCat)
    d = kde(cars.MPG[indc])
    linec = lines!(d.x, d.density, color = colors[i], linewidth = 1.5)
    bandc = band!(d.x, 0*d.density, d.density, color = (colors[i], 0.5))
    legc = [linec, bandc]
    push!(legends, legc)
end
leg = Legend(fig, legends, string.(sort(categ)), "Cyl", tellheight = true, tellwidth = false, 
    orientation = :horizontal, framevisible = false, titleposition = :left)
fig[2,1] = ax
fig[1,1] = leg
save("FigDensity_mtcarsLegTop.png", fig, px_per_unit = 2)
fig