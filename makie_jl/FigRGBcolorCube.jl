using GeometryBasics
using GLMakie, Colors
positions = vec([(i/5, j/5, k/5) for i=1:7,j=1:7,k=1:7]) # note 7 > 5 [factor in each i,j,k], whichs is misleading

fig, ax, obj = mesh(HyperRectangle(Vec3f0(positions[1]...), Vec3f0(0.15)), color = RGBA(positions[1]..., 0.5),
    transparency = false)
wireframe!(ax,HyperRectangle(Vec3f0(positions[1]...), Vec3f0(0.15)), linewidth = 0.1, overdraw = false)
for i in 2:length(positions)
    mesh!(ax, HyperRectangle(Vec3f0(positions[i]...), Vec3f0(0.15)), color = RGBA(positions[i]..., 0.5))
    wireframe!(ax, HyperRectangle(Vec3f0(positions[i]...), Vec3f0(0.15)), linewidth = 0.1, overdraw = false)
end
fig
save("FigRGBcolorCube.png", fig, px_per_unit = 2)