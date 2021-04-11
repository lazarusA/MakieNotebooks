using GLMakie, ColorSchemes, Colors

set_theme!(
    rowgap = 5,
    colgap = 5,
    fontsize = 16, 
    backgroundcolor = :black, # "#212946",
    Axis = (
        xgridcolor = :white, 
        ygridcolor = :white, 
        backgroundcolor = :black, # "#212946",
        xgridstyle=:dash, 
        ygridstyle=:dash, 
        xgridwidth=0.35, 
        ygridwidth=0.35, 
        xtickalign=0, 
        ytickalign=0, 
        xtickcolor = :white, 
        ytickcolor = :white,
        bottomspinecolor = :white, 
        topspinecolor =:white,
        leftspinecolor =:white,
        rightspinecolor =:white,
        xlabelcolor=:white, 
        ylabelcolor = :white,
        xticklabelcolor = :white, 
        yticklabelcolor = :white,
        xgridvisible = true, 
        ygridvisible = true),
    Colorbar = (
        topspinevisible = false, 
        rightspinevisible = false,
        bottomspinevisible = false, 
        leftspinevisible = false,
        width = 12, 
        height = Relative(4/4), 
        labelcolor = :white,
        ticklabelcolor = :white,
        tickalign = 1, 
        tickcolor = :white, 
        labelpadding = -5, 
        ticklabelsize = 16),
    Legend = (#titlecolor = :white # not working or missing
        tellheight = false, 
        tellwidth = false, 
        halign = :right, 
        valign = :top, 
        labelsize = 16,
        linewidth = 2,
        markersize = 7, 
        margin = (10, 10, 10, 10),
        framevisible = true, 
        framecolor = (:white, 0.25),
        bgcolor = (:grey, 0.25), 
        labelcolor = :white, 
        titlecolor = :white)
)

# archimedean spiral
a, m, z₀ = 1, 2.1, 0
φ = LinRange(0,20π,500)
r = a*φ
x, y, z = r .* cos.(φ), r .* sin.(φ), m .* r .+ z₀;

fig = Figure(resolution = (900, 800))
ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))
line3d = lines!(x, y, z, color = z, colormap = :viridis)
lines!(x, y, 0*z, color = z, colormap = (:viridis, 0.35))

axis = ax.scene[OldAxis]
axis[:names, :axisnames] = ("x", "y", "z")
tstyle = axis[:names] #  get the nested attributes and work directly with them

tstyle[:textsize] = 10
tstyle[:textcolor] = (:red, :green, :white)
tstyle[:font] = "helvetica"
tstyle[:gap] = 5
axis[:ticks][:textcolor] = :white
axis[:ticks][:textsize] = 5
cbar = Colorbar(fig, line3d, label = "z",ticklabelsize = 14,
    width = 12, height = Relative(2/4), tickalign=0)
fig[1, 1] = ax
fig[1, 2] = cbar
save("FigLines3D_black_bg.png", fig, px_per_unit = 1)
fig