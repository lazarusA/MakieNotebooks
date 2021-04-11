# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie

Θ = LinRange(0, 2π, 100) # 50
Φ = LinRange(0, π, 20)
r = 1
x = [r * cos(θ) * sin(ϕ)      for θ in Θ, ϕ in Φ]
y = [r * sin(θ) * sin(ϕ)      for θ in Θ, ϕ in Φ]
z = [r * cos(ϕ) for θ in Θ, ϕ in Φ]

fig = Figure(resolution = (570, 500))
ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))
sphere = surface!(x, y, z, colormap = :magma, shading=false)
axis = ax.scene[OldAxis]
axis[:names, :axisnames] = ("x", "y", "z")
tstyle = axis[:names] #  get the nested attributes and work directly with them

tstyle[:textsize] = 12
tstyle[:textcolor] = (:red, :green, :black)
tstyle[:font] = "helvetica"
tstyle[:gap] = 5
axis[:ticks][:textcolor] = :black
axis[:ticks][:textsize] = 7
cbar = Colorbar(fig, sphere, label = "z",ticklabelsize = 12,
    width = 12, height = Relative(2/4), tickalign=0)
fig[1, 1] = ax
fig[1, 2] = cbar
save("FigSphere.png", fig, px_per_unit = 1)
fig