# - By [lazarusA](https://lazarusa.github.io/Webpage/index.html)
using FileIO, GLMakie, GeometryBasics, LinearAlgebra
using AbstractPlotting: get_dim, surface_normals
bunny = load("bunny.obj")

ptstemp = bunny.position
npts = length(ptstemp)
points = zeros(npts, 3)
for i in 1:npts
    points[i,:] = ptstemp[i]
end
# normalize into a box and/or translations
mnpts = minimum(points, dims=1)
mxpts = maximum(points, dims=1)
for (i, ele) in enumerate(bunny.position)
    newele = (ele .- ((mxpts .+ mnpts)./2)')/maximum(mxpts .- mnpts)
    bunny.position[i] =  newele .+ [0,1,0]
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
Θ = LinRange(0, 2π, 100) # 50
Φ = LinRange(0, π, 100)
r = 0.5
x = [r * cos(θ) * sin(ϕ) for θ in Θ, ϕ in Φ]
y = [r * sin(θ) * sin(ϕ) for θ in Θ, ϕ in Φ]
z = [r * cos(ϕ) for θ in Θ, ϕ in Φ]
Z = z .* exp.(0.6*z).+ z/3;
meshSphere = getMesh(x,y, Z);

α = Node(-0.05)
β = Node(0)
γ = Node(0)
αβγ = @lift(($α, $β, $γ))

fig = Figure(resolution = (1200, 800))
ax = LScene(fig, scenekw = (camera = cam3d!, show_axis = true))
sphere = mesh!(ax, meshSphere, color= [v[3] for v in coordinates(meshSphere)], # color = z, # v[3]
    colormap = :tab20b, shading = true, 
    ambient = Vec3f0(0.6, 0.6, 0.6), backgroundcolor = :white) # limits = FRect((-1,-1,-1), (3,3,2))


eggM =  ax.scene[end]
GLMakie.rotate!(eggM, Quaternionf0(0.5, 0.5, 0.6, 0.5))

mesh!(ax,  getMesh(x,y .+1, Z .+ 0.5), color= [v[3] for v in coordinates(meshSphere)], # color = z, # v[3]
    colormap = :tol_light, shading = true,
    lightposition = Vec3f0(0, 0, 1.5), ambient = Vec3f0(0.9, 0.9, 0.9))

mesh!(ax,  getMesh(x,y .-1, Z .+ 0.5), color= [v[3] for v in coordinates(meshSphere)], # color = z, # v[3]
    colormap = :tableau_sunset_sunrise, shading = true, 
    lightposition = Vec3f0(0.2, -1, 1.5), ambient = Vec3f0(0.9, 0.9, 0.9))

mesh!(ax, normal_mesh(bunny), color= [v[2] for v in coordinates(bunny)],
    colormap = :flag_gi, shading = true, ambient = Vec3f0(0.6, 0.6, 0.6))

rabbit =  ax.scene[end]
GLMakie.rotate!(rabbit, Quaternionf0(0.5, 0.5, 0.5, 0.5))

axis = ax.scene[OldAxis]
axis[:names, :axisnames] = ("x", "y", "z")
tstyle = axis[:names] #  get the nested attributes and work directly with them

tstyle[:textsize] = 10
tstyle[:textcolor] = (:black, :black, :black)
tstyle[:font] = "helvetica"
tstyle[:gap] = 5
axis[:ticks][:textcolor] = :black
axis[:ticks][:textsize] = 7
text!("Happy Easter!", position = Point3f0(0, -1, 2),
    color = :black,
    rotation = π/2,
    #align = (:center, :center),
    textsize = 0.25,
    space = :data
)
rotate_cam!(ax.scene, (-0.3,-0.0,0))

fig[1, 1] = ax
#fig[1, 2] = cbar
save("bunnyW.png", fig, px_per_unit = 2)
fig