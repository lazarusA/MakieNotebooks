using GLMakie, ColorSchemes, Colors # using CairoMakie seems to fail here. 

U = LinRange(-pi, pi, 100) 
V = LinRange(-pi, pi, 20)

x1 = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
y1 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
z1 = [.5 * sin(v)                        for u in U, v in V]
x2 = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
y2 = [.5 * sin(v)                        for u in U, v in V]
z2 = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]


fig = Figure(resolution =(600,400))
ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))


ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))
tori1 = wireframe!(ax, x1,y1,z1, shading = false, color = :orange, transparency=false)
tori2 = wireframe!(ax, x2,y2,z2, shading = false, color= :dodgerblue, transparency=true)

axis = ax.scene[OldAxis]


axis[:names, :axisnames] = ("x", "y", "z")
tstyle = axis[:names] #  get the nested attributes and work directly with them

tstyle[:textsize] = 10
tstyle[:textcolor] = (:red, :green, :black)
tstyle[:font] = "helvetica"
tstyle[:gap] = 5
axis[:ticks][:textcolor] = :black
axis[:ticks][:textsize] = 5

elem_1 = [LineElement(color = tori1[:color], linestyle = nothing)]
elem_2 = [LineElement(color = tori2[:color], linestyle = nothing)]

leg = Legend(fig, [elem_1, elem_2], ["tori 1", "tori 2"], 
    tellheight = false, tellwidth = false, 
    halign = :left, valign = :center, framevisible = false, bgcolor = :white)
fig[1, 1] = ax
fig[1, 1] = leg
save("FigWireframe_Tori1_2.png", fig, px_per_unit = 1)
fig