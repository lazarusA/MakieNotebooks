using GLMakie, ColorSchemes, Colors

u = LinRange(-1.5, 2, 50)
v = LinRange(0, 2*pi, 50)

X1 = [u for u in u, v in v]
Y1 = [(u^2 + 1)*cos(v) for u in u, v in v]
Z1 = [(u^2 + 1)*sin(v)  for u in u, v in v]

fig, _ = surface(X1, Y1, Z1, shading = true,  ambient = Vec3f0(0.95, 0.95, 0.95), backlight = 0.95f0,
    color = sqrt.(X1.^2 .+ Y1.^2 .+ Z1.^2), colormap = :viridis)
wireframe!(X1, Y1, Z1)
save("FigRevolution1.png", fig, px_per_unit = 1)
fig