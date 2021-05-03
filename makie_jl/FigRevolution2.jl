using GLMakie, ColorSchemes, Colors

u = LinRange(0, 1, 50)
v = LinRange(0, 2π, 50)

X1 = [u for u in u, v in v]
Y1 = [(u^4 - u^2)*cos(v) for u in u, v in v]
Z1 = [(u^4 - u^2)*sin(v)  for u in u, v in v]

fig, _ = surface(X1, Y1, Z1, shading = true,  ambient = Vec3f0(0.65, 0.65, 0.65), backlight = 0.95f0,
    color = sqrt.(X1.^2 .+ Y1.^2 .+ Z1.^2), colormap = :plasma)
save("FigRevolution2.png", fig, px_per_unit = 1)
fig