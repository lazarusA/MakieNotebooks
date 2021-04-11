using RDatasets, StatsBase, KernelDensity, Colors
using CairoMakie, ColorSchemes # using GLMakie
# modifying the default theme
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
## the actual plot
airquality = dataset("datasets", "airquality")
categories = ["Ozone", "Solar.R", "Wind", "Temp"]

fig = Figure(resolution = (600, 400), font = "sans")
ax = Axis(fig, xlabel = "", ylabel = "", xticks = ([1,2,3,4], categories) )
colors = ColorScheme(range(colorant"black", colorant"red", length=length(categories)))

for (indx,f) in enumerate(categories)
    testm = []
    for v in airquality[:,f]
        if v !== missing
            push!(testm, v)
        end
    end
    a = repeat([indx], inner = length(testm))
    b = testm
    violin!(a, b; width = 0.35,  color = (colors[indx], 0.45), 
        strokecolor = colors[indx], show_median = true, mediancolor = :black)
end
fig[1,1] = ax
#save("./results/FigAirqualityViolin.png", fig, px_per_unit = 2)
fig