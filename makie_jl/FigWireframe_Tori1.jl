# By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using CairoMakie, ColorSchemes, Colors # using GLMakie
U = LinRange(-pi, pi, 100) # 50
V = LinRange(-pi, pi, 20)
x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
z1 = [.5 * sin(v)                        for u in U, v in V]

fig = Figure(resolution =(600,400))
ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))
wireframe!(x1,y1,z1, shading = false)
axis = ax.scene[OldAxis]
tstyle = axis[:names]
tstyle[:textsize] = 12
tstyle[:gap] = 5
axis[:ticks][:textcolor] = :black
axis[:ticks][:textsize] = 7
fig[1,1] = ax
save("FigWireframe_Tori1.png", fig, px_per_unit = 1)
fig