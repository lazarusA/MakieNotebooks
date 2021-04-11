using GLMakie, ColorSchemes, Colors # using CairoMakie seems to fail here. 

U = LinRange(-pi, pi, 100) 
V = LinRange(-pi, pi, 20)

x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
z1 = [.5 * sin(v)                        for u in U, v in V]
x2 = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
y2 = [.5 * sin(v)                        for u in U, v in V]
z2 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]

fig = Figure(resolution =(1200,800))
ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))

tori1 = surface!(ax, x1, y1, z1, colormap = :viridis, shading=false)
tori2 = surface!(ax, x2, y2, z2, colormap = :plasma, shading=false)
axis = ax.scene[OldAxis]
axis[:names, :axisnames] = ("x", "y", "z")
tstyle = axis[:names] #  get the nested attributes and work directly with them

tstyle[:textsize] = 10
tstyle[:textcolor] = (:red, :green, :black)
tstyle[:font] = "helvetica"
tstyle[:gap] = 5
axis[:ticks][:textcolor] = :black
axis[:ticks][:textsize] = 5
cbar1 = Colorbar(fig, tori1, label = "z",ticklabelsize = 16,
    width = 12, height = Relative(2/4), tickalign=1, # cbar's frame
)
cbar2 = Colorbar(fig, tori2, label = "z",ticklabelsize = 16,labelpadding = -5,
    flipaxisposition= false, ticklabelpad = 35,
    width = 12, height = Relative(2/4), tickalign=1,
   )
fig[1, 2] = ax
fig[1, 3] = cbar1
fig[1, 1] = cbar2
save("FigTori1_2cmap.png", fig, px_per_unit = 1)
fig