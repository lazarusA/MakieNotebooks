using CairoMakie # using GLMakie
# modifying the default theme
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
## the actual plot
x = -1:0.05:1
y = -1.5:0.05:2
egg(x,y) = x^2 + y^2/(1.4 + y/5)^2
segg = [egg(x,y) for x in x, y in y]

fig = Figure(resolution = (470, 550))
ax = Axis(fig, xlabel = "x", ylabel = "y")
clines = contour!(x, y, segg, linewidth = 1.2, colormap = :matter, levels = 0:0.02:1)
cbar  = Colorbar(fig, clines, label ="egg-l", labelpadding = 0)
fig[1, 1] = ax
fig[1, 2] = cbar
#save("./results/FigContour2.svg", scene, pt_per_unit = 0.7);
save("FigContour2_1.png", fig, px_per_unit = 2)
fig