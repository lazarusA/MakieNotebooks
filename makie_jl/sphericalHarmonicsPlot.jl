using Legendre, GLMakie
using GeometryBasics, LinearAlgebra, StatsBase
using AbstractPlotting
using AbstractPlotting: get_dim, surface_normals
# thanks to @jkrumbiegel for the lift
function Y(θ, ϕ, l, m)
    if m < 0
        return (-1)^m * √2 * Nlm(l, abs(m)) * Plm(l, abs(m), cos(θ)) * sin(abs(m)*ϕ)
    elseif m == 0
        return sqrt((2*l+1)/4π)*Plm(l, m, cos(θ))
    else
        return (-1)^m * √2 * Nlm(l, m) * Plm(l, m, cos(θ)) * cos(m*ϕ)
    end
end
function getMesh(x,y,z)
    positions = vec(map(CartesianIndices(z)) do i
    GeometryBasics.Point{3, Float32}(
        get_dim(x, i, 1, size(z)),
        get_dim(y, i, 2, size(z)),
        z[i])
    end)
    faces = decompose(GLTriangleFace, Rect2D(0f0, 0f0, 1f0, 1f0), size(z))
    normals = surface_normals(x, y, z)
    vertices = GeometryBasics.meta(positions; normals=normals)
    meshObj = GeometryBasics.Mesh(vertices, faces)
    meshObj
end

# Grids of polar and azimuthal angles
θ = LinRange(0, π, 200)
ϕ = LinRange(0, 2π, 200)
x = [sin(θ)*sin(ϕ) for θ in θ, ϕ in ϕ]
y = [sin(θ)*cos(ϕ) for θ in θ, ϕ in ϕ]
z = [cos(θ)        for θ in θ, ϕ in ϕ]

l = Node(4)
m = Node(1)

ambient =  Vec3f0(0.75, 0.75, 0.75)
cmap = (:dodgerblue, :white) # how to include this into menu options?

fig = Figure(resolution = (900, 500), backgroundcolor = :black)

menu = Menu(fig, options = ["viridis", "heat", "plasma", "magma", "inferno"])

Ygrid = lift(l, m) do l, m
    [Y(θ, ϕ, l, m) for θ in θ, ϕ in ϕ]
end
Ylm = @lift(abs.($Ygrid))
Ygrid2 = @lift(vec($Ygrid))

ax1 = Axis3(fig, aspect = :data)
ax2 = Axis3(fig, aspect = :data)
pltobj1 = mesh!(ax1, getMesh(x, y, z), color = Ygrid2, colormap = cmap, ambient = ambient)
pltobj2 = mesh!(ax2, @lift(getMesh($Ylm .* x, $Ylm .* y, $Ylm .* z)), color = Ygrid2, colormap = cmap,  ambient = ambient)
hidespines!(ax1)
hidedecorations!(ax1)
hidespines!(ax2)
hidedecorations!(ax2)
cbar = Colorbar(fig, pltobj1, label = "Yₗₘ(θ,ϕ)", width = 11, tickalign = 1, tickwidth = 1, labelcolor = :white,
        ticklabelcolor = :white,tickcolor = :white)
fig[1,1] = ax1
fig[1,2] = ax2
fig[1,3] = cbar
fig[0,1:2] = Label(fig, @lift("Tesseral Spherical Harmonics l = $($l), m = $($m)"), textsize = 20, color = (:white, 0.85))
fig[2, 0] = vgrid!(
    Label(fig, "Colormap", width = nothing, color = :white),
    menu; tellheight = false, width = 100)

on(menu.selection) do s
    pltobj1.colormap = s
    pltobj2.colormap = s
end

sl = Slider(fig[end+1, 2:3], range = 1:30, startvalue = 3)
sl2 = Slider(fig[end+1, 2:3], range = @lift(-$(sl.value):1:$(sl.value)))
connect!(l, sl.value)
connect!(m, sl2.value)

tight_ticklabel_spacing!(cbar)

fig
#save("sblackY41_blue.png", fig, px_per_unit = 2)
